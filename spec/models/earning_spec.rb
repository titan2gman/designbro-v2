# frozen_string_literal: true

RSpec.describe Earning do
  describe 'associations' do
    it { is_expected.to belong_to :project }
    it { is_expected.to belong_to :designer }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:project_id).with_options(null: false) }
    it { is_expected.to have_db_column(:designer_id).with_options(null: false) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :project }
    it { is_expected.to validate_presence_of :designer }
  end

  describe 'events' do
    subject { create(:earning) }

    it { is_expected.to transition_from(:earned).to(:paid).on_event(:request_payout) }
  end
end
