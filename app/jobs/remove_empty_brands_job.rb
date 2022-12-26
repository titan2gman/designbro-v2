# frozen_string_literal: true

class RemoveEmptyBrandsJob < ApplicationJob
  def perform
    ActiveRecord::Base.transaction do
      destroy_empty_brands
      destroy_stale_brands_and_projects
    end
  end

  def destroy_empty_brands
    Brand.left_outer_joins(brand_dnas: :projects)
         .where('brands.updated_at < ?', 24.hours.ago)
         .where(projects: { id: nil })
         .update_all(visible: false)
  end

  def destroy_stale_brands_and_projects
    Brand.joins(brand_dnas: :projects)
         .where(brands: { name: [nil, ''] })
         .where('brands.updated_at < ?', 24.hours.ago)
         .where('brand_dnas.updated_at < ?', 24.hours.ago)
         .where('projects.updated_at < ?', 24.hours.ago)
         .update_all(visible: false)
  end
end
