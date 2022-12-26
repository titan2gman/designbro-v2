# frozen_string_literal: true

class ExistingDesign < ApplicationRecord
  belongs_to :project

  has_one :existing_logo, as: :entity, class_name: 'UploadedFile::ExistingLogo', validate: true, dependent: :destroy

  validates :existing_logo, presence: true

  # for admin panel
  accepts_nested_attributes_for :existing_logo
end
