# frozen_string_literal: true

RSpec.describe Projects::NotifySourceFilesUploaded do
  subject { described_class.new }

  let(:project_1) { create(:project, state: Project::STATE_REVIEW_FILES) }
  let(:project_2) { create(:project, state: Project::STATE_DESIGN_STAGE) }
  let(:client_mailer_double) { double('ClientMailerDouble', deliver_later: true) }

  describe '#call' do
    before do
      project_1
      project_2
    end

    it 'sends email two times' do
      expect(subject).to receive(:projects) { Project.all }
      expect(ClientMailer).to receive(:review_files_stage_started)
        .twice
        .and_return(client_mailer_double)
      expect(client_mailer_double).to receive(:deliver_later).twice
      subject.call
    end
  end

  describe '#projects' do
    let(:time_now) { Time.current.change(usec: 0) }
    let(:five_minutes_ago) { time_now - 5.minutes }
    let(:eleven_minutes_ago) { time_now - 11.minutes }

    let(:project_1) { create(:project, state: Project::STATE_REVIEW_FILES) }
    let(:project_2) { create(:project, state: Project::STATE_DESIGN_STAGE) }
    let(:project_3) { create(:project, state: Project::STATE_FINALIST_STAGE) }
    let(:project_4) { create(:project, state: Project::STATE_COMPLETED) }
    let(:project_5) { create(:project, state: Project::STATE_FILES_STAGE) }

    let(:project_source_file_1) { create(:project_source_file, project: project_1) }
    let(:project_source_file_2) { create(:project_source_file, project: project_1) }
    let(:project_source_file_3) { create(:project_source_file, project: project_1) }
    let(:project_source_file_4) { create(:project_source_file, project: project_2) }
    let(:project_source_file_5) { create(:project_source_file, project: project_3) }
    let(:project_source_file_6) { create(:project_source_file, project: project_4) }
    let(:project_source_file_7) { create(:project_source_file, project: project_5) }
    let(:project_source_file_8) { create(:project_source_file, project: project_5) }
    let(:project_source_file_9) { create(:project_source_file, project: project_5) }

    before do
      project_source_file_1.source_file.update_column(:created_at, five_minutes_ago)
      project_source_file_2.source_file.update_column(:created_at, eleven_minutes_ago)
      project_source_file_3.source_file.update_column(:created_at, five_minutes_ago)
      project_source_file_4.source_file.update_column(:created_at, five_minutes_ago)
      project_source_file_5.source_file.update_column(:created_at, five_minutes_ago)
      project_source_file_6.source_file.update_column(:created_at, five_minutes_ago)
      project_source_file_7.source_file.update_column(:created_at, five_minutes_ago)
      project_source_file_8.source_file.update_column(:created_at, eleven_minutes_ago)
      project_source_file_9.source_file.update_column(:created_at, five_minutes_ago)
    end

    it 'returns project_1 and project_2' do
      result = subject.send(:projects).pluck(:id)
      expect(result.count).to eq 2
      expect(result).to match [project_1.id, project_5.id]
    end
  end
end
