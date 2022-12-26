# frozen_string_literal: true

class ProjectBrandExample < ApplicationRecord
  enum example_type: { skip: 0, bad: 1, good: 2 }

  # associations

  belongs_to :project

  belongs_to :brand_example, class_name: 'UploadedFile::BrandExample'

  # validations

  validates :example_type, :project, :brand_example, presence: true
end
