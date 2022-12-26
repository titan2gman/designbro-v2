# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdditionalDesignPrice, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :product }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to monetize(:amount) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(4).is_less_than_or_equal_to(10) }
    it { is_expected.to validate_numericality_of(:amount_cents).is_greater_than_or_equal_to(0) }
  end
end
