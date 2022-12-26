# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectAudienceStepForm do
  describe '#save' do
    context 'with valid attributes' do
      it "successfully updates project in DB (state: #{Project::STATE_WAITING_FOR_AUDIENCE_DETAILS})" do
        attributes = attributes_for(:project).slice(
          :low_income_or_high_income,
          :masculine_or_premium,
          :target_country_codes,
          :youthful_or_mature
        )

        project = create(:project, state: Project::STATE_WAITING_FOR_AUDIENCE_DETAILS)

        form = ProjectAudienceStepForm.new(
          attributes.merge(
            id: project.id,
            upgrade_project_state: true
          )
        )

        expect(form.valid?).to be_truthy
        expect { form.save }.to change { Project.count }.by 0
        expect(form.project.state).to eq Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
      end
    end

    context 'with invalid attributes' do
      it 'does not update project in DB without specified project ID' do
        attributes = attributes_for(:project).slice(
          :low_income_or_high_income,
          :masculine_or_premium,
          :target_country_codes,
          :youthful_or_mature
        )

        form = ProjectAudienceStepForm.new attributes

        expect(form.project).not_to receive :update
        expect(form.save).to be_falsey
      end

      it 'does not update project in DB without target audience params' do
        form = ProjectAudienceStepForm.new(
          upgrade_project_state: true,
          id: create(:project).id,
          target_country_codes: ['UA']
        )

        expect(form.project).not_to receive :update
        expect(form.save).to be_falsey
      end

      it 'does not update project in DB with invalid target audience params' do
        form = ProjectAudienceStepForm.new Hash.new(123).merge(
          upgrade_project_state: true,
          id: create(:project).id,
          target_country_codes: ['UA']
        )

        expect(form.project).not_to receive :update
        expect(form.save).to be_falsey
      end
    end
  end
end
