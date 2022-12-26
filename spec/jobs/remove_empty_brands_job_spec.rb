# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RemoveEmptyBrandsJob do
  describe '#perform_later' do
    it 'creates job' do
      expect { described_class.perform_later }.to have_enqueued_job(described_class)
      expect(described_class).to have_been_enqueued.exactly(:once)
    end
  end

  describe 'destroy_stale_brands_and_projects' do
    it 'should update brand visibility' do
      brand = create(:brand, updated_at: 2.days.ago, name: '')
      brand_dna = create(:brand_dna, brand: brand, updated_at: 2.days.ago)
      create(:project, brand_dna: brand_dna, updated_at: 2.days.ago)

      expect(Brand.count).to eq 1

      described_class.perform_now

      expect(Brand.count).to eq 1

      Brand.all.map(&:visible).each do |visible|
        expect(visible).to be_falsey
      end
    end

    it 'should not update brand visibility' do
      brand = create(:brand, updated_at: 2.hours.ago, name: '')
      brand_dna = create(:brand_dna, brand: brand, updated_at: 2.hours.ago)
      create(:project, brand_dna: brand_dna, updated_at: 2.hours.ago)

      expect(Brand.count).to eq 1

      described_class.perform_now

      expect(Brand.count).to eq 1

      Brand.all.map(&:visible).each do |visible|
        expect(visible).to be_truthy
      end
    end
  end
  describe 'destroy_empty_brands' do
    it 'should update brand visibility' do
      brand = create(:brand, updated_at: 2.days.ago)
      create(:brand_dna, brand: brand)

      expect(Brand.count).to eq 1

      described_class.perform_now

      expect(Brand.count).to eq 1

      Brand.all.map(&:visible).each do |visible|
        expect(visible).to be_falsey
      end
    end

    it 'should not update brand visibility' do
      brand = create(:brand, updated_at: 2.hours.ago)
      create(:brand_dna, brand: brand)

      expect(Brand.count).to eq 1

      described_class.perform_now

      expect(Brand.count).to eq 1

      Brand.all.map(&:visible).each do |visible|
        expect(visible).to be_truthy
      end
    end
  end
end
