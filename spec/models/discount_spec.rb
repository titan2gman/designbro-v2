# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Discount do
  describe 'columns' do
    it { is_expected.to have_db_column(:code).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:discount_type).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:value).of_type(:integer).with_options(null: false) }

    it { is_expected.to have_db_column(:begin_date).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:end_date).of_type(:datetime).with_options(null: false) }

    it { is_expected.to have_db_column(:used_num).of_type(:integer).with_options(null: false, default: 0) }
    it { is_expected.to have_db_column(:max_num).of_type(:integer).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects) }
  end

  describe 'validations' do
    subject { create(:discount, code: 'CODE') }

    it { is_expected.to validate_uniqueness_of(:code) }

    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount_type) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:begin_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to validate_presence_of(:max_num) }

    describe 'datetime' do
      describe 'begin date' do
        it { expect(subject.begin_date).to be_within(1.second).of(Time.zone.now) }

        it 'raises an error on create' do
          expect { create(:discount, begin_date: 1.day.ago) }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      describe 'end date' do
        it { expect(subject.end_date).to be > subject.begin_date }

        it 'raises an error' do
          expect { create(:discount, begin_date: Time.zone.now, end_date: 1.day.ago) }
            .to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe '#monetize' do
    describe 'percent discount' do
      subject { create(:percent_discount, value: 25) }
      let(:project) { create(:logo_project) }

      it 'returns discount size' do
        create(:logo_project_price, price: 1000)

        expect(subject.monetize(project.project_type_price)).to eq(250)
      end
    end

    describe 'dollar discount' do
      subject { create(:dollar_discount, value: 250) }
      let(:project) { create(:logo_project) }

      it 'returns discount size' do
        create(:logo_project_price)

        expect(subject.monetize(project.project_type_price)).to eq(250)
      end
    end
  end

  describe '#available' do
    subject { create(:discount) }

    it { expect(subject.unavailable?).to be false }

    it 'discount was used max count of times' do
      subject.update(used_num: subject.max_num)

      expect(subject.unavailable?).to be true
    end

    it 'discount has not start yet' do
      subject.update(begin_date: 1.hour.from_now)

      expect(subject.unavailable?).to be true
    end

    it 'discount has been finished' do
      subject.update(end_date: 1.hour.ago)

      expect(subject.unavailable?).to be true
    end
  end
end
