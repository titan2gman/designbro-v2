# frozen_string_literal: true

module NewProject
  class CheckoutForm < NewProject::StepBaseForm
    attribute :vat, String
    attribute :country, String
    attribute :country_code, String
    attribute :discount_code, String

    validates :id, presence: true, if: :validate_form?

    private

    def persist_project_discount!
      project.discount = discount
      project.discount_amount = discount.monetize(project.project_type_price + BigDecimal(project.nda_price.to_s))
      project.designer_discount_amount = discount.monetize(project.project_type_price)

      project.save
    end

    def calculate_project_price
      project_type_price + vat_price + nda_price - discount_amount
    end

    def vat_price
      BigDecimal(project.company ? VatCalculator.new(project).call.to_s : 0)
    end

    def nda_price
      BigDecimal(project.nda_price.to_s)
    end

    def discount_amount
      BigDecimal(project.discount_amount.to_s)
    end

    def project_type_price
      BigDecimal(project.project_type_price.to_s)
    end

    def discount
      @discount ||= Discount.active.find_by(code: discount_code)
    end

    def discount_available
      discount && !(discount.unavailable? && discount != project.discount)
    end
  end
end
