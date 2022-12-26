# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckOutdatedEntitiesJob do
  describe '#perform_later' do
    it 'creates job' do
      expect { described_class.perform_later }.to have_enqueued_job(described_class)
      expect(described_class).to have_been_enqueued.exactly(:once)
    end
  end

  describe 'uploaded files deletion' do
    let(:deletion_types) do
      ['UploadedFile::ExistingLogo', 'UploadedFile::CompetitorLogo', 'UploadedFile::InspirationImage', 'UploadedFile::TechnicalDrawing', 'UploadedFile::AdditionalDocument', 'UploadedFile::DesignerPortfolioWork']
    end

    it 'deletes records by type' do
      non_deletion_types = ['UploadedFile::DesignFile', 'UploadedFile::SourceFile', 'UploadedFile::BrandExample', 'UploadedFile::PortfolioImageFile']

      [deletion_types, non_deletion_types].flatten.each do |type|
        create(:uploaded_file, type: type, entity: nil, updated_at: 3.weeks.ago)
      end

      expect(UploadedFile.count).to eq(deletion_types.length + non_deletion_types.length)

      described_class.perform_now

      expect(UploadedFile.count).to eq(non_deletion_types.length)
      expect(UploadedFile.all.map(&:type)).to match_array(non_deletion_types)
    end

    it 'deletes records by entity' do
      [nil, 1].each do |entity_id|
        deletion_types.each do |type|
          create(:uploaded_file, type: type, entity_id: entity_id, updated_at: 3.weeks.ago)
        end
      end

      expect(UploadedFile.count).to eq(2 * deletion_types.length)

      described_class.perform_now

      expect(UploadedFile.count).to eq(deletion_types.length)
      expect(UploadedFile.all.map(&:entity_id)).to match_array(Array.new(deletion_types.length) { 1 })
    end

    it 'deletes records by updated_at' do
      [2.weeks.ago, 3.weeks.ago].each do |updated_at|
        deletion_types.each do |type|
          create(:uploaded_file, type: type, entity: nil, updated_at: updated_at)
        end
      end

      expect(UploadedFile.count).to eq(2 * deletion_types.length)

      described_class.perform_now

      expect(UploadedFile.count).to eq(deletion_types.length)
      UploadedFile.all.map(&:updated_at).each do |updated_at|
        expect(updated_at).to be > 3.weeks.ago
      end
    end
  end
end
