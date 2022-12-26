# frozen_string_literal: true

module NewProject
  class DetailsStepForm < NewProject::CheckoutForm
    presents :project

    attribute :nda_type, String
    attribute :nda_value, String
    attribute :upgrade_package, Boolean
    attribute :max_spots_count, Integer
    attribute :max_screens_count, Integer

    validates :upgrade_package, inclusion: [true, false]
    validates :nda_type, inclusion: ['standard', 'custom', 'free']
    validates :nda_value, presence: true, if: proc { nda_custom? && validate_form? }
    validates :nda_type, presence: true, if: :validate_form?
    validates :max_spots_count, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: Project::MAX_SPOTS_COUNT }
    validates :max_screens_count, numericality: { greater_than_or_equal_to: Project::MIN_SCREENS_COUNT, less_than_or_equal_to: Project::MAX_SCREENS_COUNT }

    validate :upgrade_package_ability

    private

    def persist!
      persist_project_nda!
      persist_project_discount! if discount_available
      persist_project!
    end

    def persist_project!
      project.update!(
        max_screens_count: max_screens_count,
        max_spots_count: max_spots_count,
        upgrade_package: upgrade_package,
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

    def upgrade_package_ability
      errors.add(:upgrade_package, :can_upgrade_only_logo_project) if upgrade_package && !project.product.key == 'logo'
    end

    def nda_custom?
      nda_type == 'custom'
    end

    def nda_standard?
      nda_type == 'standard'
    end

    def nda_free?
      nda_type == 'free'
    end
  end
end
