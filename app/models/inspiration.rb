# frozen_string_literal: true

class Inspiration < ApplicationRecord
  belongs_to :project

  has_one :inspiration_image, as: :entity, class_name: 'UploadedFile::InspirationImage', validate: true, dependent: :destroy

  validates :inspiration_image, presence: true

  # for admin panel
  accepts_nested_attributes_for :inspiration_image
end
