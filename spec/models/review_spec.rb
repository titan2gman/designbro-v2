# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review do
  describe 'indexes' do
    it { is_expected.to have_db_index(:client_id) }
    it { is_expected.to have_db_index(:design_id).unique }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:design_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:client_id).of_type(:integer).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to belong_to :design }
    it { is_expected.to belong_to :client }

    it { is_expected.to have_one(:designer).through(:design) }
    it { is_expected.to have_one(:project).through(:design) }
  end

  describe 'validations' do
    # attributes

    it do
      is_expected.to validate_numericality_of(:designer_rating)
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(5)
        .only_integer
    end

    it do
      is_expected.to validate_numericality_of(:overall_rating)
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(5)
        .only_integer
    end

    it { is_expected.to validate_presence_of :designer_rating }
    it { is_expected.to validate_presence_of :designer_comment }

    it { is_expected.to validate_presence_of :overall_rating }
    it { is_expected.to validate_presence_of :overall_comment }

    # associations

    it { is_expected.to validate_presence_of :design }
    it { is_expected.to validate_presence_of :client }

    describe 'design uniqueness' do
      subject { build(:review) }

      it { is_expected.to validate_uniqueness_of :design }
    end
  end
end
