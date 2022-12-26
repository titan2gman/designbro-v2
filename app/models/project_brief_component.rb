# frozen_string_literal: true

class ProjectBriefComponent < ApplicationRecord
  belongs_to :product
  acts_as_list scope: :product
end
