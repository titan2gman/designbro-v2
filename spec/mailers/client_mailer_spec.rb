# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientMailer do
  let(:project) { create(:project) }
  let(:user) { project.client.user }

  PROJECT_TYPE_DESIGN_STAGE_TIMING = {
    logo: 10,
    brand_identity: 10,
    packaging: 12
  }.freeze

  PROJECT_TYPE_FINALIST_STAGE_TIMING = {
    logo: 5,
    brand_identity: 7,
    packaging: 5
  }.freeze

  FILES_STAGE_TIMING = 3

  REVIEW_FILES_STAGE_TIMING = 10

  # payments

  [:logo, :brand_identity, :packaging].each do |project_type|
    describe '#bank_transfer_payment_received' do
      let(:project) { create(:project, project_type: project_type) }
      let(:user) { project.client.user }
      let(:mail) { ClientMailer.bank_transfer_payment_received(project: project).deliver }

      it { expect(mail.subject).to eq('Payment Received - Your project has started!') }
      it { expect(mail.to).to match_array([user.email]) }
      it { expect(mail.from).to match_array(['chris@designbro.com']) }
      it { expect(mail.body.encoded).to include("You have #{PROJECT_TYPE_DESIGN_STAGE_TIMING[project_type]} days to select your finalists, make sure you do so on time") }
    end

    describe '#payment_received' do
      let(:project) { create(:project, project_type: project_type) }
      let(:user) { project.client.user }
      let(:mail) { ClientMailer.payment_received(project: project).deliver }

      it { expect(mail.subject).to eq('Congratulations with your new design project') }
      it { expect(mail.to).to match_array([user.email]) }
      it { expect(mail.from).to match_array(['chris@designbro.com']) }
      it { expect(mail.body.encoded).to include("You have #{PROJECT_TYPE_DESIGN_STAGE_TIMING[project_type]} days to select your finalists, make sure you do so on time") }
    end
  end

  describe '#not_paid_project' do
    let(:project) { create(:project) }
    let(:user) { project.client.user }
    let(:mail) { ClientMailer.not_paid_project(project: project).deliver }

    it { expect(mail.subject).to eq("We can make a great design for #{project.brand_name}!") }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to include(CGI.escapeHTML("Having a great design for #{project.brand_name}, could be the best decision you ever made.")) }
  end

  # warnings

  describe '#design_stage_three_days_left' do
    let(:mail) { ClientMailer.design_stage_three_days_left(project: project).deliver }

    it { expect(mail.subject).to eq('Only 3 days left - Time to pick your finalists now') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Please review the designs, you only have 3 days left to select 3 Finalists.') }
  end

  describe '#design_stage_one_day_left' do
    let(:mail) { ClientMailer.design_stage_one_day_left(project: project).deliver }

    it { expect(mail.subject).to eq('Don’t lose your project: Only 1 day left!') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Hey, you only have 1 day left to pick 3 finalists for your project') }
  end

  describe '#finalist_stage_two_days_left' do
    let(:mail) { ClientMailer.finalist_stage_two_days_left(project: project).deliver }

    it { expect(mail.subject).to eq('Only 2 days left - Time to pick your winner now') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Please review the designs, you only have 2 days left to select your winner!') }
  end

  describe '#finalist_stage_one_day_left' do
    let(:mail) { ClientMailer.finalist_stage_one_day_left(project: project).deliver }

    it { expect(mail.subject).to eq('Don’t lose your project: Only 1 day left!') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Hey, you only have 1 day left to pick the winning design for your project') }
  end

  describe '#review_files_stage_three_days_left' do
    let(:mail) { ClientMailer.review_files_stage_three_days_left(project: project).deliver }

    it { expect(mail.subject).to eq('Time to check your files! - Only 3 days to go.') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Hey - time to check out your design files') }
  end

  describe '#files_stage_time_out' do
    let(:mail) { ClientMailer.files_stage_time_out(project: project).deliver }

    it { expect(mail.subject).to eq('Houston. We have a problem...') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('The designer didn’t upload his files for your project') }
  end

  describe '#file_auto_approve' do
    let(:mail) { ClientMailer.file_auto_approve(project: project).deliver }

    it { expect(mail.subject).to eq('Great! You’re done!') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to include("Congrats with your new #{project.project_type.humanize}") }
  end

  describe '#review_files_stage_started' do
    let(:mail) { ClientMailer.review_files_stage_started(project: project).deliver }

    it { expect(mail.subject).to eq('Great News! Your designer uploaded the files for you.') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to include("The files for your project: #{project.name} are now uploaded") }
  end

  describe '#new_source_file_uploaded' do
    let(:mail) { ClientMailer.new_source_file_uploaded(project: project).deliver }

    it { expect(mail.subject).to eq('Files have been updated') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Your design files have been updated') }
  end

  describe '#new_design_uploaded' do
    let(:design)  { create(:design) }
    let(:project) { design.project }
    let(:client)  { project.client }
    let(:user)    { client.user }

    let(:mail) { ClientMailer.new_design_uploaded(design: design).deliver }

    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq(['chris@designbro.com']) }
    it { expect(mail.subject).to eq('A new design has been uploaded') }
    it { expect(mail.body.encoded).to include('A new design has been uploaded') }
  end

  # state changed

  describe '#design_stage_time_out' do
    let(:mail) { ClientMailer.design_stage_time_out(project: project).deliver }

    it { expect(mail.subject).to eq('Wow. Something went wrong...') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('You lost your project, if this happened by accident, we urgently ask you to contact') }
  end

  describe '#finalist_stage_time_out' do
    let(:mail) { ClientMailer.finalist_stage_time_out(project: project).deliver }

    it { expect(mail.subject).to eq('What happened???') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('You lost your project, if this happened by accident, we urgently ask you to contact') }
  end

  describe '#finalist_stage_started' do
    let(:mail) { ClientMailer.finalist_stage_started(project: project).deliver }

    it { expect(mail.subject).to eq('Big steps! Moving on to the Finalists stage.') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('Thank you for selecting your finalists, you just put a smile on the designer’s face') }
  end

  describe '#brand_identity_finalist_stage_started' do
    let(:mail) { ClientMailer.brand_identity_finalist_stage_started(project: project).deliver }

    it { expect(mail.subject).to eq('Big steps! Moving on to the Finalists stage.') }
    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.body.encoded).to match('In the finalist stage your selected designers will make your stationery items.') }
  end
end
