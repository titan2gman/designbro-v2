# frozen_string_literal: true

class StripeSuccessProjectPaymentCallback
  def initialize(project_id, stripe_session_id)
    @project = Project.find_by!(id: project_id, stripe_session_id: stripe_session_id)
    @stripe_session = Stripe::Checkout::Session.retrieve(stripe_session_id)
    @stripe_payment_intent = Stripe::PaymentIntent.retrieve(stripe_session.payment_intent)
    @stripe_charge = stripe_payment_intent.charges.first

    @stripe_balance_transaction = get_stripe_balance_transaction(stripe_charge)

    @stripe_fee_details = stripe_balance_transaction.fee_details

    @stripe_fee = stripe_fee_details.find { |details| details.type == 'stripe_fee' }
    @stripe_tax = stripe_fee_details.find { |details| details.type == 'tax' }
  end

  def call
    ActiveRecord::Base.transaction do
      update_project
      update_nda
      create_payment
    end
  end

  def redirect_url
    "/new-project/#{project.id}/#{next_step ? next_step.path : 'success'}"
  end

  attr_accessor :project,
                :stripe_session,
                :stripe_payment_intent,
                :stripe_charge,
                :stripe_balance_transaction,
                :stripe_fee_details,
                :stripe_fee,
                :stripe_tax

  private

  def update_nda
    @project.brand.active_nda.update!(
      paid: true
    )
  end

  def update_project
    @project.upgrade_to_brand_identity! if @project.upgrade_package

    update_step
  end

  def create_payment
    Payment.create!(
      payment_type: :credit_card,
      project: project,
      total_price_paid_cents: project.normalized_price,

      nda_price_paid_cents: nda_price * 100,
      vat_price_paid_cents: vat_price * 100,
      discount_amount_saved_cents: discount_amount,

      payment_intent_id: stripe_session.payment_intent,
      charge_id: stripe_charge.id,
      processing_fee_cents: stripe_fee.amount,
      processing_fee_currency: stripe_fee.currency,
      processing_fee_vat_cents: stripe_tax&.amount,
      processing_fee_vat_currency: stripe_tax&.currency
    )
  end

  def update_step
    project.current_step = next_step
    project.save!
    project.finish_creation! unless next_step
  end

  def next_step
    @next_step ||= find_next_step
  end

  def find_next_step
    if project.contest?
      if project.brand.has_paid_project
        step.lower_items.mandatory_for_existing_brand.first
      else
        step.lower_item
      end
    elsif project.payments.any?
      if project.brand.has_paid_project
        step.lower_items.mandatory_for_existing_brand.mandatory_for_one_to_one_project.first
      else
        step.lower_items.mandatory_for_one_to_one_project.first
      end
    else
      step.lower_item
    end
  end

  def step
    @step ||= project.current_step
  end

  def get_stripe_balance_transaction(charge)
    if charge.balance_transaction.is_a? String
      Stripe::BalanceTransaction.retrieve(charge.balance_transaction)
    else
      charge.balance_transaction
    end
  end

  def nda_price
    project.nda_price.to_i
  end

  def vat_price
    project.company ? VatCalculator.new(project).call : 0
  end

  def discount_amount
    project.discount_amount_cents
  end
end
