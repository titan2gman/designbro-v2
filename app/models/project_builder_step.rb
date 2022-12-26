# frozen_string_literal: true

class ProjectBuilderStep < ApplicationRecord
  belongs_to :product
  has_many :project_builder_questions, dependent: :destroy

  scope :mandatory_for_existing_brand, -> { where(mandatory_for_existing_brand: true) }
  scope :mandatory_for_one_to_one_project, -> { where(mandatory_for_one_to_one_project: true) }

  acts_as_list scope: :product

  validates :path, :form_name, presence: true
  validates :path, uniqueness: { scope: :product_id }
end
