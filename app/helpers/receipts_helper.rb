# frozen_string_literal: true

module ReceiptsHelper
  def project_type_name
    "#{@project.product.name} Design"
  end

  def project_type_price
    BigDecimal(@project.full_price.to_s)
  end

  def payment_type_name
    payment_type = @payment.payment_type
    I18n.t "paid_with.#{payment_type}"
  end

  def nda_free?(nda)
    nda.nda_type == 'free'
  end

  def vat_percent(project)
    country_code = project.company.country_code
    vat = project.company.vat

    return 0 if non_european_country?(country_code) || vat.present?

    VatRate.where(country_code: country_code).first.percent
  end

  def upgrade_price
    Product.find_by(key: 'brand-identity').price - Product.find_by(key: 'logo').price
  end

  private

  def non_european_country?(country_code)
    VatRate.where(country_code: country_code).empty?
  end
end
