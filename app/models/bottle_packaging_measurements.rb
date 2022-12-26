# frozen_string_literal: true

class BottlePackagingMeasurements < ApplicationRecord
  has_one :project, as: :packaging_measurements

  has_one :technical_drawing, as: :entity, class_name: 'UploadedFile::TechnicalDrawing', validate: true, dependent: :destroy

  validates :label_width, :label_height, presence: true, if: proc { technical_drawing.nil? }

  def packaging_type
    :bottle
  end
end
