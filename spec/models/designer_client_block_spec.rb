# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DesignerClientBlock, type: :model do
  subject { create(:designer_client_block) }

  describe 'associations' do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:designer) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:client_id) }
    it { is_expected.to have_db_index(:designer_id) }

    it { is_expected.to have_db_index([:client_id, :designer_id]).unique }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:client_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:designer_id).of_type(:integer).with_options(null: false) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:client) }
    it { is_expected.to validate_presence_of(:designer) }
  end
end
