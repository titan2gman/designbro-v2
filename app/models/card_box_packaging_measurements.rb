# frozen_string_literal: true

class CardBoxPackagingMeasurements < ApplicationRecord
  has_one :project, as: :packaging_measurements

  has_one :technical_drawing, as: :entity, class_name: 'UploadedFile::TechnicalDrawing', validate: true, dependent: :destroy

  validates :side_depth, :front_width, :front_height, presence: true, if: proc { technical_drawing.nil? }

  def packaging_type
    :card_box
  end
end
