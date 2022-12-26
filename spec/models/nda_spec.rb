# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nda do
  describe 'associations' do
    it { is_expected.to belong_to :project }

    it { is_expected.to have_many(:designer_ndas).dependent(:destroy) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:value).of_type(:text) }
    it { is_expected.to have_db_column(:project_id).of_type(:integer).with_options(null: false, index: true) }
    it { is_expected.to have_db_column(:nda_type).of_type(:integer).with_options(null: false, index: true, default: 'standard') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:project) }

    describe 'project uniqueness' do
      subject { build(:nda) }

      it { is_expected.to validate_uniqueness_of(:project) }
    end
  end

  describe '#price' do
    it 'should return standard nda price if nda type is standard' do
      nda_price = create(:standard_nda_price)
      expect(create(:standard_nda).price).to eq(nda_price.price)
    end

    it 'should return custom nda price if nda type is custom' do
      nda_price = create(:custom_nda_price)
      expect(create(:custom_nda).price).to eq(nda_price.price)
    end

    it 'should return free nda price if nda type is free' do
      nda_price = create(:free_nda_price)
      expect(create(:free_nda).price).to eq(nda_price.price)
    end
  end
end
