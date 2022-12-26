# frozen_string_literal: true

class FeaturedImage < ApplicationRecord
  belongs_to :project

  has_one :uploaded_featured_image, as: :entity, class_name: 'UploadedFile::UploadedFeaturedImage', validate: true, dependent: :destroy

  validates :project, :uploaded_featured_image, presence: true

  # for admin panel
  accepts_nested_attributes_for :uploaded_featured_image
end
