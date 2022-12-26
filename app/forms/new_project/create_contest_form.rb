# frozen_string_literal: true

module NewProject
  class CreateContestForm < NewProject::CreateForm
    include Wisper::Publisher

    attribute :designer_id, Integer

    presents :project

    private

    def persist!
      ActiveRecord::Base.transaction do
        update_project!
        create_spot! if designer_id
      end
    end

    def update_project!
      project.update!(
        product: product,
        project_type: project_type,
        current_step: current_step,
        brand_dna: brand_dna,
        max_spots_count: designer_id ? 1 : 3,
        referrer: referrer
      )
    end

    def project_type
      designer_id ? 'one_to_one' : 'contest'
    end

    def current_step
      if brand.has_paid_project
        product.project_builder_steps.mandatory_for_existing_brand.first
      else
        product.project_builder_steps.first
      end
    end

    def create_spot!
      project.spots.create!(
        designer_id: designer_id,
        state: 'reserved',
        reserved_state_started_at: DateTime.now
      )
    end
  end
end
