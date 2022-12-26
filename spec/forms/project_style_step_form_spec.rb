# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectStyleStepForm do
  describe '#save' do
    context 'with valid attributes' do
      it "successfully updates project in DB (state: #{Project::STATE_WAITING_FOR_STYLE_DETAILS})" do
        attributes = attributes_for(:project).slice(
          :stand_out_or_not_from_the_crowd,
          :handcrafted_or_minimalist,
          :traditional_or_modern,
          :serious_or_playful,
          :detailed_or_clean,
          :value_or_premium,
          :outmoded_actual,
          :bold_or_refined
        )

        project = create(:project, state: Project::STATE_WAITING_FOR_STYLE_DETAILS)

        form = ProjectStyleStepForm.new(
          attributes.merge(
            id: project.id,
            upgrade_project_state: true
          )
        )

        expect(form.valid?).to be_truthy

        expect { form.save }.to change { Project.count }.by 0

        attributes.each do |field_name, expected_value|
          value = form.project.public_send(field_name)
          expect(value).to eq(expected_value)
        end

        expect(form.project.state).to eq Project::STATE_WAITING_FOR_AUDIENCE_DETAILS.to_s
      end

      it "successfully updates project in DB (state: #{Project::STATE_WAITING_FOR_FINISH_DETAILS})" do
        attributes = attributes_for(:project).slice(
          :stand_out_or_not_from_the_crowd,
          :handcrafted_or_minimalist,
          :traditional_or_modern,
          :serious_or_playful,
          :detailed_or_clean,
          :value_or_premium,
          :outmoded_actual,
          :bold_or_refined
        )

        project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS)

        form = ProjectStyleStepForm.new(
          attributes.merge(
            id: project.id,
            contibue_project: true
          )
        )

        expect(form.valid?).to be_truthy

        expect { form.save }.to change { Project.count }.by 0

        attributes.each do |field_name, expected_value|
          value = form.project.public_send(field_name)
          expect(value).to eq(expected_value)
        end

        expect(form.project.state).to eq Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
      end
    end

    context 'with invalid attributes' do
      it 'does not update project in DB without specified project ID' do
        attributes = attributes_for(:project).slice(
          :stand_out_or_not_from_the_crowd,
          :handcrafted_or_minimalist,
          :traditional_or_modern,
          :serious_or_playful,
          :detailed_or_clean,
          :value_or_premium,
          :outmoded_actual,
          :bold_or_refined
        )

        form = ProjectStyleStepForm.new attributes

        expect(form.project).not_to receive :update
        expect(form.save).to be_falsey
      end

      it 'does not update project in DB without style params' do
        form = ProjectStyleStepForm.new id: create(:project).id

        expect(form.project).not_to receive :update
        expect(form.save).to be_falsey
      end

      it 'does not update project in DB with invalid style params' do
        form = ProjectStyleStepForm.new Hash.new(123).merge id: create(:project).id

        expect(form.project).not_to receive :update
        expect(form.save).to be_falsey
      end
    end
  end
end
