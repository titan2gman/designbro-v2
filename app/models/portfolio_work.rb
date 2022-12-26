# frozen_string_literal: true

class PortfolioWork < ApplicationRecord
  belongs_to :designer
  belongs_to :product_category

  has_one :uploaded_file, as: :entity, class_name: 'UploadedFile::DesignerPortfolioWork', validate: true, dependent: :nullify

  validates :description, presence: true
  validates :uploaded_file, presence: true
end
