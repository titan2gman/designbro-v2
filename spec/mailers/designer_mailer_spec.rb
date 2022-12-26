# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DesignerMailer do
  let(:user) { create(:designer).user }
  let(:project) { create(:project) }
  before { create(:designer_nda, nda: project.nda, designer: user.designer) }

  describe '#portfolio_approved' do
    let(:mail) { DesignerMailer.portfolio_approved(user: user).deliver }

    it { expect(mail.subject).to eq('Guess what..you’re in!') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Your work really impressed our team') }
  end

  describe '#portfolio_disapproved' do
    let(:mail) { DesignerMailer.portfolio_disapproved(user: user).deliver }

    it { expect(mail.subject).to eq('Sorry...') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('your portfolio has been declined.') }
  end

  # warnings

  describe '#reservation_12_hours_left' do
    let(:mail) { DesignerMailer.reservation_12_hours_left(user: user, project: project).deliver }

    it { expect(mail.subject).to eq(I18n.t('designer_mailer.reservation_12_hours_left.subject')) }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match(I18n.t('designer_mailer.reservation_12_hours_left.body')) }
  end

  describe '#files_stage_two_days_left' do
    before { create(:winner_design, project: project, designer: user.designer) }
    let(:mail) { DesignerMailer.files_stage_two_days_left(project: project).deliver }

    it { expect(mail.subject).to eq('Only 2 days left - Time to upload your files') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('It is time to upload your files') }
  end

  describe '#files_stage_one_day_left' do
    before { create(:winner_design, project: project, designer: user.designer) }
    let(:mail) { DesignerMailer.files_stage_one_day_left(project: project).deliver }

    it { expect(mail.subject).to eq('Warning: You are about to lose your project.') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Action needed: you only have 1 day left to upload your files') }
  end

  # state changed

  describe '#selected_as_finalist' do
    let(:mail) { DesignerMailer.selected_as_finalist(user: user, project: project).deliver }

    it { expect(mail.subject).to eq('Congratulations - You have been selected as a finalist!') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Entering the home stretch! Please check if the client asked for any changes, and...') }
  end

  describe '#selected_as_finalist_for_brand_identity' do
    let(:mail) { DesignerMailer.selected_as_finalist_for_brand_identity(user: user, project: project).deliver }

    it { expect(mail.subject).to eq('Big steps! Moving on to the Finalists stage.') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Nice! Now that you have entered the finalist stage, you are expected to make the stationery items for the client') }
  end

  describe '#selected_as_winner' do
    before { create(:winner_design, project: project, designer: user.designer) }
    let(:mail) { DesignerMailer.selected_as_winner(project: project).deliver }

    it { expect(mail.subject).to eq('Whoop Whoop! You Won!!') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Congratulations! Awesome news, the client selected you as the winner of the project') }
  end

  describe '#contest_completed' do
    before { create(:winner_design, project: project, designer: user.designer) }
    let(:mail) { DesignerMailer.contest_completed(project: project).deliver }

    it { expect(mail.subject).to eq('Signed, Sealed Delivered!') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Fantastic! The client approved your files') }
  end

  # time_out

  describe '#design_stage_time_out' do
    let(:mail) { DesignerMailer.design_stage_time_out(user: user, project: project).deliver }

    it { expect(mail.subject).to eq('Ok... We have some bad news...') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('This means that the client didn’t select any finalists.') }
  end

  describe '#finalist_stage_time_out' do
    let(:mail) { DesignerMailer.finalist_stage_time_out(user: user, project: project).deliver }

    it { expect(mail.subject).to eq('Ok... We have some bad news...') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('This means that the client didn’t select a winner.') }
  end

  describe '#files_stage_time_out' do
    before { create(:winner_design, project: project, designer: user.designer) }
    let(:mail) { DesignerMailer.files_stage_time_out(project: project).deliver }

    it { expect(mail.subject).to eq('URGENT: What happened???') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Hey! You forgot to upload the files') }
  end

  describe '#design_eliminated' do
    let(:design)   { create(:design) }
    let(:designer) { design.designer }

    let(:mail) { DesignerMailer.design_eliminated(design: design).deliver }

    it { expect(mail.to).to eq([designer.email]) }
    it { expect(mail.from).to eq(['chris@designbro.com']) }
    it { expect(mail.subject).to eq('Better luck next time') }
    it { expect(mail.body.encoded).to include('The client eliminated your design') }
  end

  describe '#designer_blocked' do
    let(:design)   { create(:design) }
    let(:designer) { design.designer }

    let(:mail) { DesignerMailer.designer_blocked(design: design).deliver }

    it { expect(mail.to).to eq([designer.email]) }
    it { expect(mail.subject).to eq('You got blocked') }
    it { expect(mail.from).to eq(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to include('The client decided to block you') }
  end
end
