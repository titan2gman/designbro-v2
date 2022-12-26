# frozen_string_literal: true

class PlasticPackPackagingMeasurements < ApplicationRecord
  has_one :project, as: :packaging_measurements

  has_one :technical_drawing, as: :entity, class_name: 'UploadedFile::TechnicalDrawing', validate: true, dependent: :destroy

  validates :technical_drawing, presence: true

  def packaging_type
    :plastic_pack
  end
end
