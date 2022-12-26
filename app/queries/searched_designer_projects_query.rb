# frozen_string_literal: true

class SearchedDesignerProjectsQuery < SearchedProjectsQuery
  def search
    super
    @projects = @projects.discoverable

    return @projects if @sort_params.present?

    @projects.order(Arel.sql(default_sort_params))
  end

  private

  def default_sort_params
    <<-SQL
      CASE projects.state
        WHEN '#{Project::STATE_DESIGN_STAGE}' THEN 1
        WHEN '#{Project::STATE_FINALIST_STAGE}' THEN 2
        WHEN '#{Project::STATE_FILES_STAGE}' THEN 3
        ELSE 4
      END ASC,
      (projects.max_spots_count - (SELECT count(*) FROM spots
                                   WHERE project_id = projects.id
                                   AND state IN (#{spots_visible_states}))) DESC,
      CASE projects.state
        WHEN '#{Project::STATE_DESIGN_STAGE}' THEN (projects.design_stage_expires_at - now())
        WHEN '#{Project::STATE_FINALIST_STAGE}' THEN (projects.finalist_stage_expires_at - now())
        WHEN '#{Project::STATE_FILES_STAGE}' THEN (projects.files_stage_expires_at - now())
      END ASC
    SQL
  end

  def spots_visible_states
    Spot::VISIBLE_STATES.map { |state| "'#{state}'" }.join(', ')
  end
end
