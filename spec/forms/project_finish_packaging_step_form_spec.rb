# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectFinishPackagingStepForm do
  describe '#save' do
    context 'with valid attributes' do
      before do
        @attributes = attributes_for(:project).slice(
          :background_story,
          :where_it_is_used,
          :what_is_special,
          :additional_text,
          :what_to_design,
          :design_type,
          :brand_name
        )

        @project = create(
          :packaging_project,
          state: Project::STATE_WAITING_FOR_FINISH_DETAILS
        )

        project_competitor = create(:project_competitor, project: @project)
        project_inspiration = create(:project_inspiration, project: @project)
        project_existing_logo = create(:project_existing_logo, project: @project)
        project_additional_document = create(:project_additional_document, project: @project)

        @competitor = attributes_for(:project_competitor)
                      .merge(id: project_competitor.competitor_logo.id)

        @inspiration = attributes_for(:project_inspiration)
                       .merge(id: project_inspiration.inspiration_image.id)

        @existing_logo = attributes_for(:project_existing_logo)
                         .merge(id: project_existing_logo.existing_logo.id)

        @additional_document = attributes_for(:project_additional_document)
                               .merge(id: project_additional_document.additional_document.id)

        @colors = Array.new(3) { Faker::Color.hex_color }

        @attributes.merge!(
          additional_documents: [@additional_document],
          existing_logos: [@existing_logo],
          inspirations: [@inspiration],
          competitors: [@competitor],
          what_to_design: 'Design',
          inspirations_exist: true,
          competitors_exist: true,
          colors_exist: true,
          logos_exist: true,
          colors: @colors,
          id: @project.id
        )
      end

      after do
        expect(@project.reload.additional_documents.first.comment).to eq @additional_document[:comment]
        expect(@project.reload.competitors.first.comment).to eq @competitor[:comment]
        expect(@project.reload.inspirations.first.comment).to eq @inspiration[:comment]
        expect(@project.reload.existing_logos.first.comment).to eq @existing_logo[:comment]
      end

      it "successfully saves data to DB with #{Project::STATE_WAITING_FOR_FINISH_DETAILS} state" do
        @attributes[:upgrade_project_state] = true

        @form = ProjectFinishPackagingStepForm.new(@attributes)

        expect(@form.valid?).to be_truthy

        expect { @form.save }
          .to change { Project.count }
          .by(0).and change { ProjectInspiration.count }
          .by(0).and change { ProjectCompetitor.count }
          .by(0).and change { ProjectAdditionalDocument.count }
          .by(0).and change { ProjectExistingLogo.count }
          .by(0).and change { ProjectColor.count }.by(3)

        expect(@project.reload.state).to eq Project::STATE_WAITING_FOR_DETAILS.to_s
      end

      it 'does not update project state if upgrade_project_state is false' do
        @attributes[:upgrade_project_state] = false

        @form = ProjectFinishPackagingStepForm.new(@attributes)

        expect(@form.valid?).to be_truthy

        expect { @form.save }
          .to change { Project.count }
          .by(0).and change { ProjectInspiration.count }
          .by(0).and change { ProjectCompetitor.count }
          .by(0).and change { ProjectAdditionalDocument.count }
          .by(0).and change { ProjectExistingLogo.count }
          .by(0).and change { ProjectColor.count }.by(3)

        expect(@project.reload.state).to eq(Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s)
      end
    end

    context 'validations', type: :model do
      subject { ProjectFinishPackagingStepForm.new(upgrade_project_state: true) }

      it { is_expected.to validate_presence_of :brand_name }
      it { is_expected.to validate_presence_of :design_type }
      it { is_expected.to validate_presence_of :what_is_special }
      it { is_expected.to validate_presence_of :where_it_is_used }
      it { is_expected.to validate_presence_of :background_story }
    end

    context 'with invalid attributes' do
      it 'does not update project state' do
        project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS)

        form = ProjectFinishLogoStepForm.new(
          id: project.id,
          logos_exist: true,
          competitors_exist: true,
          inspirations_exist: true,
          upgrade_project_state: true
        )

        expect(form.valid?).to be_falsey

        errors = form.errors.messages

        expect(errors[:competitors]).to include('should have 1..5 items')
        expect(errors[:inspirations]).to include('should have 1..3 items')
        expect(errors[:existing_logos]).to include('should have 1..4 items')
        expect(project.reload.state).to eq(Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s)
      end
    end
  end
end
