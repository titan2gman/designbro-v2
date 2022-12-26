# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlasticPackPackagingMeasurements do
  describe 'associations' do
    it { is_expected.to have_one(:project) }

    it { is_expected.to have_one(:technical_drawing).class_name(UploadedFile::TechnicalDrawing).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :technical_drawing }
  end
end
