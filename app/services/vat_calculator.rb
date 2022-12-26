# frozen_string_literal: true

# Depricated
# TODO: remove and switch to VatCalculator
class VatCalculator
  def initialize(project)
    @project = project
    @vat_number = @project.company.vat
    @country_code = @project.company.country_code
  end

  def call
    if is_ireland? || (is_european_country? && !@vat_number&.present?)
      ((Money.new(@project.project_type_price * 100, 'USD') + @project.nda_price - @project.discount_amount) * vat_percent).to_d
    else
      BigDecimal(0)
    end
  end

  private

  def is_european_country?
    VatRate.where(country_code: @country_code).exists?
  end

  def is_ireland?
    @country_code == 'IE'
  end

  def vat_percent
    VatRate.where(country_code: @country_code.upcase).first.percent / 100.0
  end
end
