# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :clients, dependent: :destroy
  has_many :brands, dependent: :destroy
  has_many :brand_dnas, through: :brands
  has_many :projects, through: :brand_dnas

  def last_unfinished_project
    projects.unfinished.last
  end

  def country
    ISO3166::Country.new(country_code)
  end

  alias_attribute :name, :company_name
end
