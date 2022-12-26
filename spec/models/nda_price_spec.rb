# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NdaPrice do
  describe 'columns' do
    it { is_expected.to have_db_column(:price_cents).of_type(:integer).with_options(null: false, default: 0) }
    it { is_expected.to have_db_column(:price_currency).of_type(:string).with_options(null: false, default: 'USD') }
    it { is_expected.to have_db_column(:nda_type).of_type(:integer).with_options(null: false) }
  end
end
