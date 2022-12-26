# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :product_category
  has_many :additional_design_prices
  has_many :additional_screen_prices
  has_many :project_builder_steps, -> { order(position: :asc) }
  has_many :project_brief_components

  has_many :projects

  scope :active, -> { where(active: true) }

  accepts_nested_attributes_for :additional_design_prices
  accepts_nested_attributes_for :additional_screen_prices

  monetize :price_cents
  monetize :one_to_one_price_cents

  delegate :name, to: :product_category, allow_nil: true, prefix: true

  validates :name, presence: true
  validates :key, presence: true, uniqueness: { case_sensitive: true }
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validate :additional_design_segments

  def logo?
    key == 'logo'
  end

  def packaging?
    key == 'packaging'
  end

  def brand_identity?
    key == 'brand-identity'
  end

  def self.one_to_one_recommentations(project)
    relation = active.where.not(id: project.brand.projects.pluck(:product_id).uniq)

    relation = relation.count >= 3 ? relation : active

    relation.order("CASE key WHEN 'logo' THEN 1 WHEN 'website' THEN 2 WHEN 'facebook' THEN 3 WHEN 'linkedin' THEN 4 WHEN 'website-banner' THEN 5 WHEN 'flyer' THEN 6 ELSE 7 END, id")
  end

  private

  def additional_design_segments
    sorted_by_quantity = additional_design_prices.sort_by(&:quantity)

    (1..(sorted_by_quantity.length - 2)).each do |index|
      current = sorted_by_quantity[index]
      min_amount = sorted_by_quantity[index - 1].amount
      max_amount = sorted_by_quantity[index + 1].amount

      errors.add(:base, "Amount of additional design price with #{current.quantity} quantity should be grater than #{min_amount} and less than #{max_amount}") if current.amount <= min_amount || current.amount >= max_amount
    end

    sorted_by_quantity.each do |current|
      errors.add(:base, "Amount of additional design price with #{current.quantity} quantity should be grater than 0") if current.amount.negative?
    end
  end
end
