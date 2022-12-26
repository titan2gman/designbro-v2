# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectFinishLogoStepForm do
  describe '#save' do
    context 'with valid attributes' do
      let(:project) { create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS) }

      let(:competitor) do
        project_competitor = create(:project_competitor, project: project)
        attributes_for(:project_competitor).merge(id: project_competitor.competitor_logo.id)
      end

      let(:inspiration) do
        project_inspiration = create(:project_inspiration, project: project)
        attributes_for(:project_inspiration).merge(id: project_inspiration.inspiration_image.id)
      end

      let(:existing_logo) do
        project_existing_logo = create(:project_existing_logo, project: project)
        attributes_for(:project_existing_logo).merge(id: project_existing_logo.existing_logo.id)
      end

      let(:attributes) do
        attrs = attributes_for(:project).slice(
          :ideas_or_special_requirements,
          :company_description,
          :additional_text,
          :brand_name,
          :slogan
        )

        attrs.merge(
          existing_logos: [existing_logo],
          inspirations: [inspiration],
          competitors: [competitor],
          inspirations_exist: true,
          competitors_exist: true,
          colors_exist: true,
          logos_exist: true,
          id: project.id
        )
      end

      let(:colors_comment) { Faker::Lorem.sentence }
      let(:colors) { Array.new(3) { Faker::Color.hex_color } }

      let(:form) { ProjectFinishLogoStepForm.new(attributes) }

      after do
        expect(project.reload.competitors.first.comment).to eq competitor[:comment]
        expect(project.reload.inspirations.first.comment).to eq inspiration[:comment]
        expect(project.reload.existing_logos.first.comment).to eq existing_logo[:comment]
      end

      describe 'when upgrade_project_state = true' do
        let(:attributes) { super().merge(upgrade_project_state: true) }

        after do
          expect(Project.count).to eq(1)

          expect(ProjectCompetitor.count).to eq(1)
          expect(ProjectExistingLogo.count).to eq(1)

          expect(project.reload.state).to eq Project::STATE_WAITING_FOR_DETAILS.to_s
        end

        describe 'when only array of colors specified' do
          let(:attributes) { super().merge(colors: colors, colors_comment: project.colors_comment) }

          it 'successfully saves data and updates the state' do
            # rubocop:disable Layout/MultilineMethodCallIndentation

            expect { form.save }
              .to change { ProjectColor.count }.by(3)
              .and not_change { project.reload.colors_comment }

            # rubocop:enable Layout/MultilineMethodCallIndentation
          end
        end

        describe 'when only colors comment specified' do
          let(:attributes) { super().merge(colors_comment: colors_comment) }

          it 'successfully saves data and updates the state' do
            expect { form.save }
              .to not_change { ProjectColor.count }
              .and change { project.reload.colors_comment }
          end
        end

        describe 'when both colors comment and array of colors specified' do
          let(:attributes) { super().merge(colors: colors, colors_comment: colors_comment) }

          it 'successfully saves data and updates the state' do
            # rubocop:disable Layout/MultilineMethodCallIndentation

            expect { form.save }
              .to change { ProjectColor.count }.by(3)
              .and change { project.reload.colors_comment }

            # rubocop:enable Layout/MultilineMethodCallIndentation
          end
        end
      end

      describe 'when upgrade_project_state = false' do
        let(:attributes) { super().merge(upgrade_project_state: false) }

        after do
          expect(Project.count).to eq(1)

          expect(ProjectCompetitor.count).to eq(1)
          expect(ProjectExistingLogo.count).to eq(1)

          expect(project.reload.state).to eq Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
        end

        describe 'when only array of colors specified' do
          let(:attributes) { super().merge(colors: colors, colors_comment: project.colors_comment) }

          it "successfully saves data to doesn't update the state" do
            # rubocop:disable Layout/MultilineMethodCallIndentation

            expect { form.save }
              .to change { ProjectColor.count }.by(3)
              .and not_change { project.reload.colors_comment }

            # rubocop:enable Layout/MultilineMethodCallIndentation
          end
        end

        describe 'when only colors comment specified' do
          let(:attributes) { super().merge(colors_comment: colors_comment) }

          it 'successfully saves data and updates the state' do
            expect { form.save }
              .to not_change { ProjectColor.count }
              .and change { project.reload.colors_comment }
          end
        end

        describe 'when both colors comment and array of colors specified' do
          let(:attributes) { super().merge(colors: colors, colors_comment: colors_comment) }

          it 'successfully saves data and updates the state' do
            # rubocop:disable Layout/MultilineMethodCallIndentation

            expect { form.save }
              .to change { ProjectColor.count }.by(3)
              .and change { project.reload.colors_comment }

            # rubocop:enable Layout/MultilineMethodCallIndentation
          end
        end
      end
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

        expect { form.save }
          .to change { Project.count }
          .by(0).and change { ProjectInspiration.count }
          .by(0).and change { ProjectCompetitor.count }
          .by(0).and change { ProjectExistingLogo.count }
          .by(0).and change { ProjectColor.count }.by(0)

        expect(form.valid?).to be_falsey

        project = form.project

        [:brand_name, :company_description].each do |property|
          expect(project.errors.messages[property])
            .to include('Required.')
        end

        expect(project.errors.messages[:competitors]).to include('should have 1..5 items')
        expect(project.errors.messages[:inspirations]).to include('should have 1..3 items')
        expect(project.errors.messages[:existing_logos]).to include('should have 1..4 items')
        expect(project.reload.state).to eq Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
      end
    end
  end

  describe 'validations', type: :model do
    it { is_expected.not_to validate_presence_of :colors_comment }

    describe 'of colors' do
      let(:colors_array) { Array.new(3) { Faker::Color.hex_color } }
      let(:colors_comment) { Faker::Lorem.sentence }

      describe 'is valid' do
        describe 'when only array of colors specified' do
          let(:form) do
            ProjectFinishLogoStepForm.new(
              colors_exist: true,
              colors: colors_array
            )
          end

          before { form.valid? }

          it { expect(form).to be_valid }

          [:colors, :colors_comment].each do |property|
            it "should have no errors about #{property}" do
              expect(form.errors[property]).to be_empty
            end
          end
        end

        describe 'when only comment specified' do
          let(:form) do
            ProjectFinishLogoStepForm.new(
              colors_exist: true,
              colors_comment: colors_comment
            )
          end

          before { form.valid? }

          it { expect(form).to be_valid }

          [:colors, :colors_comment].each do |property|
            it "should have no errors about #{property}" do
              expect(form.errors[property]).to be_empty
            end
          end
        end

        describe 'when both array of colors and comment specified' do
          let(:form) do
            ProjectFinishLogoStepForm.new(
              colors_exist: true,
              colors: colors_array,
              colors_comment: colors_comment
            )
          end

          before { form.valid? }

          it { expect(form).to be_valid }

          [:colors, :colors_comment].each do |property|
            it "should have no errors about #{property}" do
              expect(form.errors[property]).to be_empty
            end
          end
        end
      end

      describe 'invalid' do
        describe 'when no array and no comment specified' do
          let(:form) do
            ProjectFinishLogoStepForm.new(
              colors_exist: true
            )
          end

          before { form.valid? }

          it { expect(form).not_to be_valid }

          [:colors, :colors_comment].each do |property|
            it "should have an error about #{property}" do
              expect(form.errors[property]).not_to be_empty
            end
          end
        end
      end
    end
  end
end
