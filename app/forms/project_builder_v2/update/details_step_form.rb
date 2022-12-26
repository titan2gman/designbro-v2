# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class DetailsStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :nda_type, String
      attribute :nda_value, String
      attribute :upgrade_package, Boolean
      attribute :max_spots_count, Integer
      attribute :max_screens_count, Integer
      attribute :discount_code, String
      attribute :client, Object

      private

      def persist!
        persist_project_nda!
        persist_project_discount! if discount_available
        persist_project!
        attach_client!
      end

      def persist_project!
        project.update!(
          max_screens_count: max_screens_count,
          max_spots_count: max_spots_count,
          upgrade_package: upgrade_package
        )

        project.update!(
          price: calculate_project_price
        )

        update_step
      end

      def persist_project_nda!
        if upgrade_project_state
          self.nda_value = I18n.t('standard_nda') if nda_standard?
          self.nda_value = nil if nda_free?
        end

        price = NdaPrice.find_by(nda_type: nda_type).price

        (project.brand.active_nda || Nda.new(brand: project.brand)).update!(
          nda_type: nda_type, value: nda_value, price: price
        )
      end

      def persist_project_discount!
        project.discount = discount
        project.discount_amount = discount.monetize(project.project_type_price + BigDecimal(project.nda_price.to_s))
        project.designer_discount_amount = discount.monetize(project.project_type_price)

        project.save
      end

      def nda_standard?
        nda_type == 'standard'
      end

      def nda_free?
        nda_type == 'free'
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
end
