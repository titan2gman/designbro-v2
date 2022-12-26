# frozen_string_literal: true

RSpec.describe SupportMailer do
  let(:project) { create(:real_project) }

  describe '#design_stage_time_out' do
    let(:mail) { SupportMailer.design_stage_time_out(project: project).deliver }

    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.to).to match_array(['staging-support@designbro.com']) }

    it { expect(mail.subject).to eq('Client Timed Out in the Design stage') }
    it { expect(mail.body.encoded).to match('This client timed out in the design stage:') }
  end

  describe '#finalist_stage_time_out' do
    let(:mail) { SupportMailer.finalist_stage_time_out(project: project).deliver }

    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.to).to match_array(['staging-support@designbro.com']) }

    it { expect(mail.subject).to eq('Client Timed Out in the Final stage') }
    it { expect(mail.body.encoded).to match('This client timed out in the finalist stage:') }
  end

  describe '#files_stage_time_out' do
    before { create(:winner_design, project: project) }

    let(:mail) { SupportMailer.files_stage_time_out(project: project).deliver }

    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.to).to match_array(['staging-support@designbro.com']) }

    it { expect(mail.subject).to eq('Designer Timed Out in the File stage') }
    it { expect(mail.body.encoded).to match('This client timed out in the files stage:') }
  end

  describe '#new_feedback_created_mail' do
    let(:feedback) do
      Feedback.new(
        name: 'Vasya',
        email: 'vasya@example.com',
        subject: 'Feedback from Vasya',
        message: 'Feedback from Vasya'
      )
    end

    let(:mail) { SupportMailer.new_feedback_created_mail(feedback).deliver }

    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.to).to match_array(['staging-support@designbro.com']) }

    it { expect(mail.subject).to eq('Feedback from Vasya') }
    it { expect(mail.body.encoded).to match('Feedback from Vasya') }
  end
end
