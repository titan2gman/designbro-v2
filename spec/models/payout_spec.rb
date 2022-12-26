# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payout do
  it_should_behave_like 'transactionable', :payout_id

  describe 'associations' do
    it { is_expected.to belong_to :designer }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :country }
    it { is_expected.to validate_presence_of :address1 }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :payout_method }

    describe '#enough_earnings_for_payout' do
      let(:payout_min_amount) { create(:payout_min_amount) }
      describe 'positive case' do
        subject { build(:payout, amount: payout_min_amount.amount) }

        it { expect(subject.valid?).to be true }
      end

      describe 'negative case' do
        subject { build(:payout, amount: payout_min_amount.amount - 1) }

        it { expect(subject.valid?).to be false }
      end
    end
  end

  describe '#send_payout_request_email' do
    before { expect_any_instance_of(PayoutListener).to receive(:payout_request).with(subject) }

    it { subject.send_payout_request_email }
  end

  describe 'events' do
    subject { create(:payout) }

    it { is_expected.to transition_from(:in_progress).to(:paid).on_event(:pay) }
    it { is_expected.to transition_from(:in_progress).to(:error).on_event(:error) }
    it { is_expected.to transition_from(:in_progress).to(:canceled).on_event(:cancel) }
  end
end
