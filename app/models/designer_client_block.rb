# frozen_string_literal: true

class DesignerClientBlock < ApplicationRecord
  belongs_to :client
  belongs_to :designer

  validates :client, :designer, presence: true

  enum block_reason: {
    disappointing: 0,
    not_communicate: 1,
    was_rude: 2,
    plagiarism: 3,
    other: 4
  }
end
