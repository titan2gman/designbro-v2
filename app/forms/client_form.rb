# frozen_string_literal: true

class ClientForm < BaseForm
  presents :client

  attribute :email, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :country, String
  attribute :country_code, String
  attribute :address1, String
  attribute :address2, String
  attribute :city, String
  attribute :state_name, String
  attribute :zip, String
  attribute :phone, String
  attribute :vat, String

  attribute :payment_type, String
  attribute :payment_method_id, String

  validate :country_code_validity

  private

  def persist!
    ActiveRecord::Base.transaction do
      ok ||= client.update(client_params) && client.company.update(company_params)
      user = client.user

      if email.present? && user.email != email && !user.update_without_password(email: email)
        ok = false
        merge_errors(user)
      end

      save_stripe_payment_method if payment_method_id

      raise ActiveRecord::Rollback unless ok
    end
  end

  def merge_errors(assoc)
    assoc.errors.each { |attribute, error| record.errors.add(attribute, error) }
  end

  def client_params
    {
      first_name: first_name,
      last_name: last_name,
      preferred_payment_method: payment_type
    }.compact
  end

  def company_params
    {
      country_code: country_code,
      address1: address1,
      address2: address2,
      city: city,
      state_name: state_name,
      zip: zip,
      phone: phone,
      vat: vat
    }.compact
  end

  def country_code_validity
    errors.add(:country_code, :invalid) if @country.present? && !ISO3166::Country.new(country_code)
  end

  def save_stripe_payment_method
    payment_method = Stripe::PaymentMethod.retrieve(payment_method_id)

    client.update!(
      payment_method_id: payment_method_id,
      credit_card_number: payment_method.card.last4,
      credit_card_provider: payment_method.card.brand
    )
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
end
