# frozen_string_literal: true

class ProjectStockImage < ApplicationRecord
  belongs_to :project

  has_one :stock_image, as: :entity, class_name: 'UploadedFile::StockImage', validate: true, dependent: :destroy

  validates :project, :stock_image, presence: true

  # for admin panel
  accepts_nested_attributes_for :stock_image
end
