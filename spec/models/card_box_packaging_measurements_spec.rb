# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardBoxPackagingMeasurements do
  describe 'associations' do
    it { is_expected.to have_one(:project) }

    it { is_expected.to have_one(:technical_drawing).class_name(UploadedFile::TechnicalDrawing).dependent(:destroy) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:front_height).of_type(:string) }
    it { is_expected.to have_db_column(:front_width).of_type(:string) }
    it { is_expected.to have_db_column(:side_depth).of_type(:string) }
  end

  describe 'validations' do
    describe 'with technical drawing' do
      subject do
        CardBoxPackagingMeasurements.new(
          technical_drawing: create(
            :technical_drawing
          )
        )
      end

      it { is_expected.to be_valid }
    end

    describe 'without technical drawing' do
      it { is_expected.to validate_presence_of(:front_height) }
      it { is_expected.to validate_presence_of(:front_width) }
      it { is_expected.to validate_presence_of(:side_depth) }
    end
  end
end
