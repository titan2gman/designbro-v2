# frozen_string_literal: true

class PortfolioImage < ApplicationRecord
  has_and_belongs_to_many :portfolio_lists

  belongs_to :uploaded_file, class_name: 'UploadedFile::PortfolioImageFile', validate: true, dependent: :destroy

  accepts_nested_attributes_for :uploaded_file

  validates :uploaded_file, presence: true
end
