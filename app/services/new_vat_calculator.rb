# frozen_string_literal: true

class NewVatCalculator
  def initialize(company, price)
    @company = company
    @price = price
  end

  def call
    if company && should_calculate_vat?
      price * vat_percent
    else
      Money.new(0)
    end
  end

  private

  attr_reader :company, :price

  def country_code
    company.country_code
  end

  def vat_number
    company.vat
  end

  def should_calculate_vat?
    is_ireland? || (is_european_country? && !has_vat_number?)
  end

  def has_vat_number?
    vat_number&.present?
  end

  def is_european_country?
    VatRate.where(country_code: country_code).exists?
  end

  def is_ireland?
    country_code == 'IE'
  end

  def vat_percent
    VatRate.where(country_code: country_code.upcase).first.percent / 100.0
  end
end
