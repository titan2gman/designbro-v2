# frozen_string_literal: true

class DesignerForm < BaseForm
  presents :designer

  attribute :email, String
  attribute :display_name, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :age, Integer
  attribute :date_of_birth, Date
  attribute :country_code, String
  attribute :gender, Integer
  attribute :experience_brand, String
  attribute :experience_packaging, String
  attribute :experience_english, String
  attribute :address1, String
  attribute :address2, String
  attribute :city, String
  attribute :state_name, String
  attribute :zip, String
  attribute :phone, String
  attribute :online_portfolio, String
  attribute :experiences, Array
  attribute :date_of_birth_month, Integer
  attribute :date_of_birth_day, String
  attribute :date_of_birth_year, String

  validate :country_code_validity, if: proc { country_code.present? }
  validates :date_of_birth, presence: true

  private

  def persist!
    ActiveRecord::Base.transaction do
      ok ||= designer.update(params)
      user = designer.user
      if email.present? && user.email != email && !user.update_without_password(email: email)
        ok = false
        merge_errors(user)
      end

      raise ActiveRecord::Rollback unless ok
    end
  end

  def merge_errors(assoc)
    assoc.errors.each { |attribute, error| record.errors.add(attribute, error) }
  end

  def params
    {
      display_name: display_name,
      first_name: first_name,
      last_name: last_name,
      age: age,
      date_of_birth: date_of_birth,
      country_code: country_code,
      gender: gender,
      experience_brand: experience_brand,
      experience_packaging: experience_packaging,
      experience_english: experience_english,
      portfolio_link: online_portfolio,
      address1: address1,
      address2: address2,
      city: city,
      state_name: state_name,
      zip: zip,
      phone: phone,
      designer_experiences_attributes: experiences,
      languages: ['en']
    }.compact
  end

  def date_of_birth
    Date.parse("#{date_of_birth_day}-#{date_of_birth_month}-#{date_of_birth_year}")
  end

  def country_code_validity
    errors.add(:country_code, :invalid) unless ISO3166::Country.new(country_code)
  end
end
