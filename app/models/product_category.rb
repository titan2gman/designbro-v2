# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_many :products
  has_many :portfolio_works
  has_many :designer_experiences

  validates :name, presence: true
end
