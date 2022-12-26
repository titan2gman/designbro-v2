# frozen_string_literal: true

require 'rails_helper'

FINALIST_STAGE_WARNING_TIME = 69
FINALISTS_SELECTED_WARNING_TIME = 237
REVIEW_FILES_WARNING_TIME = 117

RSpec.describe ProjectsExpire do
  subject { ProjectsExpire.new }
  describe '#call' do
    context 'design stage' do
      it 'makes expired all projects older then 10 or 12(packaging) days' do
        logo_project_expired = create(:logo_project, state: Project::STATE_DESIGN_STAGE, design_stage_expires_at: Time.current)
        brand_identity_project_expired = create(:brand_identity_project, state: Project::STATE_DESIGN_STAGE, design_stage_expires_at: Time.current)
        packaging_project_expired = create(:packaging_project, state: Project::STATE_DESIGN_STAGE, design_stage_expires_at: Time.current)
        project = create(:project, state: Project::STATE_DESIGN_STAGE)

        ProjectsExpire.new.call
        logo_project_expired.reload
        brand_identity_project_expired.reload
        packaging_project_expired.reload
        project.reload

        expect(logo_project_expired.state).to eq(Project::STATE_ERROR.to_s)
        expect(brand_identity_project_expired.state).to eq(Project::STATE_ERROR.to_s)
        expect(packaging_project_expired.state).to eq(Project::STATE_ERROR.to_s)
        expect(project.state).to eq(Project::STATE_DESIGN_STAGE.to_s)
      end

      it 'makes finalist stage for expire design stage time with finalists' do
        project_with_finalists = create(:project, state: Project::STATE_DESIGN_STAGE, design_stage_expires_at: Time.current)
        project = create(:project, state: Project::STATE_DESIGN_STAGE)

        create(:finalist_design, project: project_with_finalists)

        ProjectsExpire.new.call
        project_with_finalists.reload
        project.reload

        expect(project_with_finalists.state).to eq(Project::STATE_FINALIST_STAGE.to_s)
        expect(project.state).to eq(Project::STATE_DESIGN_STAGE.to_s)
      end

      it 'broadcasts design_stage_three_days_left' do
        create(:logo_project, state: Project::STATE_DESIGN_STAGE, design_stage_expires_at: Time.current + 3.days)

        expect { ProjectsExpire.new.call }
          .to broadcast(:design_stage_three_days_left)
      end

      it 'broadcasts design_stage_one_day_left' do
        create(:logo_project, state: Project::STATE_DESIGN_STAGE, design_stage_expires_at: Time.current + 1.day)

        expect { ProjectsExpire.new.call }
          .to broadcast(:design_stage_one_day_left)
      end
    end

    context 'finalist stage' do
      it 'makes expired all projects older then 5 or 7(brand_identity) days' do
        logo_project_expired = create(:logo_project, state: Project::STATE_FINALIST_STAGE, finalist_stage_expires_at: Time.current)
        brand_identity_project_expired = create(:brand_identity_project, state: Project::STATE_FINALIST_STAGE, finalist_stage_expires_at: Time.current)
        packaging_project_expired = create(:packaging_project, state: Project::STATE_FINALIST_STAGE, finalist_stage_expires_at: Time.current)
        project = create(:project, state: Project::STATE_FINALIST_STAGE)

        ProjectsExpire.new.call
        logo_project_expired.reload
        brand_identity_project_expired.reload
        packaging_project_expired.reload
        project.reload

        expect(logo_project_expired.state).to eq(Project::STATE_ERROR.to_s)
        expect(brand_identity_project_expired.state).to eq(Project::STATE_ERROR.to_s)
        expect(packaging_project_expired.state).to eq(Project::STATE_ERROR.to_s)
        expect(project.state).to eq(Project::STATE_FINALIST_STAGE.to_s)
      end

      it 'broadcasts finalist_stage_two_days_left' do
        create(:logo_project, state: Project::STATE_FINALIST_STAGE, finalist_stage_expires_at: Time.current + 2.days)

        expect { ProjectsExpire.new.call }
          .to broadcast(:finalist_stage_two_days_left)
      end

      it 'broadcasts finalist_stage_one_day_left' do
        create(:logo_project, state: Project::STATE_FINALIST_STAGE, finalist_stage_expires_at: Time.current + 1.day)

        expect { ProjectsExpire.new.call }
          .to broadcast(:finalist_stage_one_day_left)
      end
    end

    context 'files stage' do
      it 'makes expired all projects older then 3 days' do
        project_expired = create(:project, state: Project::STATE_FILES_STAGE, files_stage_expires_at: Time.current)
        project = create(:project, state: Project::STATE_FILES_STAGE)

        ProjectsExpire.new.call
        project_expired.reload
        project.reload

        expect(project_expired.state).to eq(Project::STATE_ERROR.to_s)
        expect(project.state).to eq(Project::STATE_FILES_STAGE.to_s)
      end

      it 'broadcasts files_stage_two_days_left' do
        create(:project, state: Project::STATE_FILES_STAGE, files_stage_expires_at: Time.current + 2.days)

        expect { ProjectsExpire.new.call }
          .to broadcast(:files_stage_two_days_left)
      end

      it 'broadcasts files_stage_one_day_left' do
        create(:project, state: Project::STATE_FILES_STAGE, files_stage_expires_at: Time.current + 1.day)

        expect { ProjectsExpire.new.call }
          .to broadcast(:files_stage_one_day_left)
      end
    end

    context 'review files stage' do
      it 'approves all projects older then 10 days' do
        project_approved = create(:project, state: Project::STATE_REVIEW_FILES, review_files_stage_expires_at: Time.current)
        project = create(:project, state: Project::STATE_REVIEW_FILES)
        create(:winner_design, project: project_approved)

        ProjectsExpire.new.call
        project_approved.reload
        project.reload

        expect(project_approved.state).to eq(Project::STATE_COMPLETED.to_s)
        expect(project.state).to eq(Project::STATE_REVIEW_FILES.to_s)
      end

      it 'broadcasts review_files_stage_three_days_left' do
        create(:project, state: Project::STATE_REVIEW_FILES, review_files_stage_expires_at: Time.current + 3.days)

        expect { ProjectsExpire.new.call }
          .to broadcast(:review_files_stage_three_days_left)
      end

      it 'creates earning for winner' do
        project = create(:project, state: Project::STATE_REVIEW_FILES, review_files_stage_expires_at: Time.current)
        create(:winner_design, project: project)

        expect { ProjectsExpire.new.call }
          .to change { Earning.count }
      end
    end
  end
end
