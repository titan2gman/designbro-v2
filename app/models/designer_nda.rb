# frozen_string_literal: true

class DesignerNda < ApplicationRecord
  belongs_to :nda
  belongs_to :designer

  has_one :brand, through: :nda

  validates :designer, :nda, presence: true

  validates :designer_id, uniqueness: { scope: :nda_id }
end
