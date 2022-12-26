# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VatRate do
  describe 'columns' do
    it { is_expected.to have_db_column(:country_name).of_type(:string).with_options(null: false, index: true) }
    it { is_expected.to have_db_column(:country_code).of_type(:string).with_options(null: false, index: true) }
    it { is_expected.to have_db_column(:percent).of_type(:integer).with_options(null: false) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:country_name) }
    it { is_expected.to validate_presence_of(:country_code) }
    it { is_expected.to validate_presence_of(:percent) }

    describe 'country code uniqueness' do
      subject do
        VatRate.new(
          country_name: 'Ukraine',
          country_code: 'UA',
          percent: 123
        )
      end

      it { is_expected.to validate_uniqueness_of(:country_code) }
    end
  end
end
