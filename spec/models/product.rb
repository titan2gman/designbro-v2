# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  describe 'associations' do
    it { is_expected.to belong_to(:product_category) }
    it { is_expected.to have_many :additional_design_prices }
  end

  it { is_expected.to monetize(:price_cents) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:key) }
    it { is_expected.to validate_uniqueness_of(:key) }
    it { is_expected.to validate_numericality_of(:price_cents).is_greater_than_or_equal_to(0) }

    describe 'additional design prices mismatch' do
      subject { build(:product, additional_design_prices: additional_design_prices) }
      let(:additional_design_prices) do
        (4..6).map do |quantity|
          build(
            :additional_design_price,
            quantity: quantity,
            amount: 10 - quantity
          )
        end
      end

      it { is_expected.not_to be_valid }
    end

    describe 'one of additional design prices less than 0' do
      subject { build(:product, additional_design_prices: additional_design_prices) }
      let(:additional_design_prices) do
        (8..10).map do |quantity|
          build(
            :additional_design_price,
            quantity: quantity,
            amount: 11 - quantity
          )
        end
      end

      it { is_expected.not_to be_valid }
    end
  end
end
