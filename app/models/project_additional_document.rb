# frozen_string_literal: true

class ProjectAdditionalDocument < ApplicationRecord
  belongs_to :project

  has_one :additional_document, as: :entity, class_name: 'UploadedFile::AdditionalDocument', validate: true, dependent: :destroy

  validates :project, :additional_document, presence: true

  # for admin panel
  accepts_nested_attributes_for :additional_document
end
