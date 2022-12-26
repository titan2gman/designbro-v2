# frozen_string_literal: true

class Competitor < ApplicationRecord
  belongs_to :brand

  has_one :competitor_logo, as: :entity, class_name: 'UploadedFile::CompetitorLogo', validate: true, dependent: :destroy

  validates :competitor_logo, presence: true

  # for admin panel
  accepts_nested_attributes_for :competitor_logo
end
