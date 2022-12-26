# frozen_string_literal: true

RSpec.describe PouchPackagingMeasurements do
  describe 'associations' do
    it { is_expected.to have_one(:project) }

    it { is_expected.to have_one(:technical_drawing).class_name(UploadedFile::TechnicalDrawing).dependent(:destroy) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:height).of_type(:string) }
    it { is_expected.to have_db_column(:width).of_type(:string) }
  end

  describe 'validations' do
    describe 'with technical drawing' do
      subject do
        PouchPackagingMeasurements.new(
          technical_drawing: create(
            :technical_drawing
          )
        )
      end

      it { is_expected.to be_valid }
    end

    describe 'without technical drawing' do
      it { is_expected.to validate_presence_of(:height) }
      it { is_expected.to validate_presence_of(:width) }
    end
  end
end
