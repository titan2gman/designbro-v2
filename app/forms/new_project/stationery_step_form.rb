# frozen_string_literal: true

module NewProject
  class StationeryStepForm < NewProject::StepBaseForm
    presents :project

    validates :id, presence: true

    validates :compliment,
              :letter_head,
              :back_business_card_details,
              :front_business_card_details, presence: true, if: :upgrade_project_state

    attribute :compliment, String
    attribute :letter_head, String

    attribute :back_business_card_details, String
    attribute :front_business_card_details, String

    private

    def persist!
      project.assign_attributes(
        compliment: compliment,
        letter_head: letter_head,
        back_business_card_details: back_business_card_details,
        front_business_card_details: front_business_card_details
      )

      update_step
    end
  end
end
