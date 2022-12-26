# frozen_string_literal: true

class PouchPackagingMeasurements < ApplicationRecord
  has_one :project, as: :packaging_measurements

  has_one :technical_drawing, as: :entity, class_name: 'UploadedFile::TechnicalDrawing', validate: true, dependent: :destroy

  validates :width, :height, presence: true, if: proc { technical_drawing.nil? }

  def packaging_type
    :pouch
  end
end
