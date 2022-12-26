# frozen_string_literal: true

RSpec.describe Projects::AbandonedCartReminders::Send do
  subject { described_class.new(project) }

  let(:project) { create(:project, abandoned_cart_reminder_step: step) }
  let(:step) { :first_reminder }

  let(:mailer_double) { double('AbandonedCartMailer') }

  describe 'first_reminder' do
    it 'calls abandoned_cart_first_reminder' do
      expect(AbandonedCartMailer).to receive(:abandoned_cart_first_reminder)
        .with(project: anything, reminder_step: 'first_reminder')
        .and_return(mailer_double)
      expect(mailer_double).to receive(:deliver_later)
      subject.call
    end
  end

  describe 'second_reminder' do
    let(:step) { :second_reminder }

    it 'calls abandoned_cart_first_reminder' do
      expect(AbandonedCartMailer).to receive(:abandoned_cart_second_reminder)
        .with(project: anything, reminder_step: 'second_reminder')
        .and_return(mailer_double)
      expect(mailer_double).to receive(:deliver_later)
      subject.call
    end
  end
  describe 'third_reminder' do
    let(:step) { :third_reminder }

    it 'calls abandoned_cart_first_reminder' do
      expect(AbandonedCartMailer).to receive(:abandoned_cart_third_reminder)
        .with(project: anything, reminder_step: 'third_reminder')
        .and_return(mailer_double)
      expect(mailer_double).to receive(:deliver_later)
      subject.call
    end
  end

  describe 'reminding_completed' do
    let(:step) { :reminding_completed }
    it 'calls abandoned_cart_first_reminder' do
      expect(AbandonedCartMailer).not_to receive(:abandoned_cart_first_reminder)
      expect(subject.call).to be_nil
    end
  end
end
