# frozen_string_literal: true

module NewProject
  class CheckoutStepForm < NewProject::CheckoutForm
    include ::Checkoutable

    presents :project

    attribute :company_name, String

    attribute :last_name, String
    attribute :first_name, String

    attribute :client, Object
    attribute :ip, String

    validates :last_name, :first_name, :country_code, presence: true, if: :validate_form?

    validate :country_code_validity

    private

    def persist!
      persist_company!
      persist_client!
      persist_project_properties!

      send :"perform_#{payment_type}_payment" if payment_type && validate_form?

      persist_company_city! if upgrade_project_state
    end

    def country_code_validity
      errors.add(:country_code, :invalid) if @country.present? && !ISO3166::Country.new(country_code)
    end

    def persist_client!
      client.update!(
        first_name: first_name,
        last_name: last_name,
        preferred_payment_method: payment_type
      )
    end

    def persist_company!
      project.company.update!(
        country_code: country_code,
        company_name: company_name,
        vat: !company_name.present? && validate_form? ? nil : vat
      )
    end

    def persist_company_city!
      return if project.company.city

      project.company.update!(
        city: retrieve_city
      )
    end

    def update_nda_paid_status!
      project.brand.active_nda.update!(
        paid: true
      )
    end

    def create_payment!(args = {})
      Payment.create!(
        args.merge(
          payment_type: payment_type,
          project: project,
          total_price_paid_cents: calculate_project_price * 100,
          nda_price_paid_cents: nda_price * 100,
          vat_price_paid_cents: vat_price * 100,
          discount_amount_saved_cents: discount_amount * 100
        )
      )
    end

    def persist_project_properties!
      project.upgrade_to_brand_identity! if project.upgrade_package

      project.price = calculate_project_price
      project.type_price = project_type_price
      project.save!
    end

    def perform_credit_card_payment
      amount = project.normalized_price

      begin
        stripe_customer = retrieve_or_create_stripe_customer

        if payment_intent_id
          intent = Stripe::PaymentIntent.confirm(payment_intent_id)
        elsif payment_method
          intent = Stripe::PaymentIntent.create(
            customer: stripe_customer,
            payment_method: payment_method,
            amount: amount,
            currency: 'usd',
            confirmation_method: 'manual',
            confirm: true,
            setup_future_usage: 'off_session',
            expand: ['charges.data.balance_transaction']
          )
        end

        if intent.status == 'requires_action' &&
           intent.next_action.type == 'use_stripe_sdk'

          project.errors.add(:requires_action, intent.client_secret)
        elsif intent.status == 'succeeded'
          payment_method_ids = Stripe::PaymentMethod.list(customer: stripe_customer, type: 'card').map(&:id)

          payment_method_object = if payment_method_ids.include?(intent.payment_method)
                                    Stripe::PaymentMethod.retrieve(intent.payment_method)
                                  else
                                    Stripe::PaymentMethod.attach(intent.payment_method, customer: stripe_customer)
                                  end

          ActiveRecord::Base.transaction do
            update_step

            client.update!(
              payment_method_id: intent.payment_method,
              credit_card_number: payment_method_object.card.last4,
              credit_card_provider: payment_method_object.card.brand
            )

            create_payment!(stripe_payment_details(intent))
            update_nda_paid_status!
          end
        else
          project.errors.add(:credit_card, 'Invalid PaymentIntent status')
        end
      rescue Stripe::StripeError => e
        project.errors.add(:credit_card, e.message)
      end
    end

    def retrieve_or_create_stripe_customer
      if client.stripe_customer
        customer = Stripe::Customer.retrieve(client.stripe_customer)
      else
        customer = Stripe::Customer.create(
          payment_method: payment_method_id,
          email: client.email
        )

        client.update!(
          stripe_customer: customer.id
        )
      end

      customer
    end

    def perform_paypal_payment
      create_payment!(paypal_payment_details)
      update_nda_paid_status!

      update_step
    end

    def credit_card_payment?
      payment_type == :credit_card
    end

    def country
      ISO3166::Country.new(country_code)
    end

    def retrieve_city
      payment_type == :paypal ? retrieve_paypal_city : retrieve_stripe_city
    end

    def retrieve_paypal_city
      PayPal::SDK::REST::DataTypes::Payment.find(paypal_payment_id).payer.payer_info.shipping_address.city
    end

    def retrieve_stripe_city
      Geocoder.search(ip).first&.city
    end
  end

  def stripe_balance_transaction(charge)
    if charge.balance_transaction.is_a? String
      Stripe::BalanceTransaction.retrieve(charge.balance_transaction)
    else
      charge.balance_transaction
    end
  end
end
