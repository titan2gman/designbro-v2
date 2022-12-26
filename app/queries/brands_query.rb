# frozen_string_literal: true

class BrandsQuery
  attr_reader :relation

  def initialize(relation = Brand.all)
    @relation = relation
  end

  def search(search_params)
    all.ransack(search_params).result
  end

  def all
    relation.includes(
      :projects_completed, :projects_in_progress, :project_source_files, :unread_designs
    ).left_outer_joins(
      :projects
    ).select(
      'brands.*', 'max(projects.created_at) as latest_project_created_at'
    ).group(
      Brand.column_names
    ).order(
      'latest_project_created_at DESC NULLS LAST'
    )
  end
end
