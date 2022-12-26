# frozen_string_literal: true

module Checkoutable
  extend ActiveSupport::Concern

  included do
    attribute :payment_method_id, String
    attribute :payment_intent_id, String
    attribute :paypal_payment_id, String

    attribute :discount_code, String

    attribute :payment_type, Symbol
  end

  def perform_credit_card_payment
    stripe_customer = retrieve_or_create_stripe_customer

    if payment_intent_id
      intent = Stripe::PaymentIntent.confirm(payment_intent_id)
    elsif payment_method
      intent = Stripe::PaymentIntent.create(
        customer: stripe_customer,
        payment_method: payment_method,
        amount: total_price.cents,
        currency: 'usd',
        confirmation_method: 'manual',
        confirm: true,
        setup_future_usage: 'off_session',
        expand: ['charges.data.balance_transaction']
      )
    end

    if intent.status == 'requires_action' && intent.next_action.type == 'use_stripe_sdk'
      project.errors.add(:requires_action, intent.client_secret)
    elsif intent.status == 'succeeded'
      payment_method_ids = Stripe::PaymentMethod.list(customer: stripe_customer, type: 'card').map(&:id)

      payment_method_object = if payment_method_ids.include?(intent.payment_method)
                                Stripe::PaymentMethod.retrieve(intent.payment_method)
                              else
                                Stripe::PaymentMethod.attach(intent.payment_method, customer: stripe_customer)
                              end

      client.update!(
        payment_method_id: intent.payment_method,
        credit_card_number: payment_method_object.card.last4,
        credit_card_provider: payment_method_object.card.brand
      )

      create_payment!(stripe_payment_details(intent))
    else
      project.errors.add(:credit_card, :invalid, message: 'Invalid PaymentIntent status')
    end
  rescue Stripe::StripeError => e
    project.errors.add(:credit_card, :invalid, message: e.message)
  end

  def perform_paypal_payment
    create_payment!(paypal_payment_details)
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

  def stripe_payment_details(intent)
    charge = intent.charges.first

    balance_transaction = stripe_balance_transaction(charge)

    fee_details = balance_transaction.fee_details

    stripe_fee = fee_details.find { |details| details.type == 'stripe_fee' }
    tax = fee_details.find { |details| details.type == 'tax' }

    {
      payment_intent_id: intent.id,
      charge_id: charge.id,
      processing_fee_cents: stripe_fee.amount,
      processing_fee_currency: stripe_fee.currency,
      processing_fee_vat_cents: tax&.amount,
      processing_fee_vat_currency: tax&.currency
    }
  end

  def stripe_balance_transaction(charge)
    if charge.balance_transaction.is_a? String
      Stripe::BalanceTransaction.retrieve(charge.balance_transaction)
    else
      charge.balance_transaction
    end
  end

  def paypal_payment_details
    paypal_fee = PayPal::SDK::REST::DataTypes::Payment.find(paypal_payment_id).transactions.first.related_resources.first.sale.transaction_fee

    {
      charge_id: paypal_payment_id,
      processing_fee_cents: paypal_fee.value.to_f * 100,
      processing_fee_currency: paypal_fee.currency
    }
  end

  def payment_method
    payment_method_id || client.payment_method_id
  end
end
