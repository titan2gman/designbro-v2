# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projects::SetStageTime do
  before do
    Timecop.freeze(Time.current)
  end

  after do
    Timecop.return
  end

  describe '#call' do
    [:logo, :brand_identity, :packaging].each do |type|
      [:design_stage, :finalist_stage].each do |stage|
        it "updates #{stage} stage time for #{type} project" do
          project = create(
            :project,
            state: stage,
            project_type: type,
            design_stage_started_at: nil,
            design_stage_expires_at: nil,
            finalist_stage_started_at: nil,
            finalist_stage_expires_at: nil,
            files_stage_started_at: nil,
            files_stage_expires_at: nil,
            review_files_stage_started_at: nil,
            review_files_stage_expires_at: nil
          )
          expect(project.send(:"#{stage}_started_at")).to be_nil
          expect(project.send(:"#{stage}_expires_at")).to be_nil
          described_class.new(project, stage).call
          expect(project.send(:"#{stage}_started_at")).to eq Time.current
          expect(project.send(:"#{stage}_expires_at")).to eq Time.current + Project.const_get("#{type.upcase}_#{stage.upcase}_EXPIRE_TIME")
        end
      end
    end

    describe 'files_stage' do
      it 'updates files_stage stage time' do
        project = create(
          :project,
          state: :files_stage,
          design_stage_started_at: nil,
          design_stage_expires_at: nil,
          finalist_stage_started_at: nil,
          finalist_stage_expires_at: nil,
          files_stage_started_at: nil,
          files_stage_expires_at: nil,
          review_files_stage_started_at: nil,
          review_files_stage_expires_at: nil
        )
        expect(project.send(:files_stage_started_at)).to be_nil
        expect(project.send(:files_stage_expires_at)).to be_nil
        described_class.new(project, :files_stage).call
        expect(project.send(:files_stage_started_at)).to eq Time.current
        expect(project.send(:files_stage_expires_at)).to eq Time.current + Project.const_get('FILES_STAGE_EXPIRE_TIME')
      end
    end

    describe 'review_files_stage' do
      it 'updates review_files_stage stage time' do
        project = create(
          :project,
          state: :review_files,
          design_stage_started_at: nil,
          design_stage_expires_at: nil,
          finalist_stage_started_at: nil,
          finalist_stage_expires_at: nil,
          files_stage_started_at: nil,
          files_stage_expires_at: nil,
          review_files_stage_started_at: nil,
          review_files_stage_expires_at: nil
        )
        expect(project.send(:review_files_stage_started_at)).to be_nil
        expect(project.send(:review_files_stage_expires_at)).to be_nil
        described_class.new(project, :review_files_stage).call
        expect(project.send(:review_files_stage_started_at)).to eq Time.current
        expect(project.send(:review_files_stage_expires_at)).to eq Time.current + Project.const_get('REVIEW_FILES_STAGE_EXPIRE_TIME')
      end
    end
  end
end
