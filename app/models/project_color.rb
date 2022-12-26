# frozen_string_literal: true

class ProjectColor < ApplicationRecord
  belongs_to :project

  validates :hex, :project, presence: true
end
