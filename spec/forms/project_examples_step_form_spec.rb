# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectExamplesStepForm do
  describe '#save' do
    context 'with valid attributes' do
      it 'successfully updates existing project into DB' do
        brand_examples = create_list(:brand_example, 10)

        bad_examples_ids = [brand_examples[0].id]
        skip_examples_ids = [brand_examples[1].id]
        good_examples_ids = brand_examples[2..7].map(&:id)

        project_id = create(:project, project_type: :packaging, state: Project::STATE_WAITING_FOR_FINISH_DETAILS).id

        form = ProjectExamplesStepForm.new(
          good_examples: good_examples_ids,
          skip_examples: skip_examples_ids,
          bad_examples: bad_examples_ids,
          id: project_id
        )

        expect { form.save }.to change { Project.count }.by(0).and change { ProjectBrandExample.count }.by(2)

        expect(form.project.state).to eq Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
        expect(form.project.project_type).to eq 'packaging'
      end

      it 'successfully converts skip brand examples into good and bad' do
        brand_examples = create_list(:brand_example, 10)

        bad_examples_ids  = brand_examples[0..1].map(&:id)
        skip_examples_ids = brand_examples[2..3].map(&:id)
        good_examples_ids = brand_examples[4..6].map(&:id)

        project = create(:project, project_type: :logo, state: Project::STATE_WAITING_FOR_FINISH_DETAILS)

        project.brand_examples.destroy_all

        form = ProjectExamplesStepForm.new(
          good_examples: good_examples_ids,
          skip_examples: skip_examples_ids,
          bad_examples: bad_examples_ids,
          id: project.id
        )

        expect { form.save }
          .to change { Project.count }.by(0)
                                      .and change { ProjectBrandExample.count }.by(7)

        form = ProjectExamplesStepForm.new(
          good_examples: good_examples_ids,
          bad_examples: bad_examples_ids,
          skip_examples: [],
          id: project.id
        )

        expect { form.save }
          .to change { Project.count }.by(0)
                                      .and change { ProjectBrandExample.skip.count }.by(-2)

        form = ProjectExamplesStepForm.new(
          good_examples: good_examples_ids + skip_examples_ids,
          bad_examples: bad_examples_ids,
          skip_examples: [],
          id: project.id
        )

        expect { form.save }
          .to change { Project.count }.by(0)
                                      .and change { ProjectBrandExample.good.count }.by(+2)
      end

      it 'successfully updates existing project into DB but does not change state' do
        brand_examples = create_list(:brand_example, 10)

        bad_examples_ids = [brand_examples[0].id]
        skip_examples_ids = [brand_examples[1].id]
        good_examples_ids = brand_examples[2..7].map(&:id)

        project_id = create(:project, project_type: :packaging, state: Project::STATE_WAITING_FOR_FINISH_DETAILS).id

        form = ProjectExamplesStepForm.new(
          good_examples: good_examples_ids,
          skip_examples: skip_examples_ids,
          bad_examples: bad_examples_ids,
          id: project_id
        )

        expect { form.save }.to change { Project.count }.by(0).and change { ProjectBrandExample.count }.by(2)

        expect(form.project.state).to eq Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
        expect(form.project.project_type).to eq 'packaging'
      end
    end

    context 'with invalid attributes' do
      it 'does not update project into DB' do
        form = ProjectExamplesStepForm.new(upgrade_project_state: true)

        expect(form.valid?).to be_falsy

        error_message = I18n.t 'errors.messages.have_n_or_more_items', count: 3
        expect(form.errors.messages[:good_examples]).to include error_message
      end
    end
  end

  describe 'validations', type: :model do
    describe 'with id - update existing project' do
      subject { ProjectExamplesStepForm.new(id: create(:project).id, upgrade_project_state: true) }
      it { is_expected.not_to validate_presence_of :project_type }
    end
  end
end
