# frozen_string_literal: true

class CanPackagingMeasurements < ApplicationRecord
  has_one :project, as: :packaging_measurements

  has_one :technical_drawing, as: :entity, class_name: 'UploadedFile::TechnicalDrawing', validate: true, dependent: :destroy

  validates :height, :volume, :diameter, presence: true, if: proc { technical_drawing.nil? }

  def packaging_type
    :can
  end
end
