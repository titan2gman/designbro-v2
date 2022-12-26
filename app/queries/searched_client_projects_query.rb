# frozen_string_literal: true

class SearchedClientProjectsQuery < SearchedProjectsQuery
  def initialize(projects:, search_params: {}, sort_params: [], spots_state: nil)
    super
    @sort_params << 'created_at desc'
  end
end
