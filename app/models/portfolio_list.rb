# frozen_string_literal: true

class PortfolioList < ApplicationRecord
  has_and_belongs_to_many :portfolio_images

  def display_name
    list_type
  end
end
