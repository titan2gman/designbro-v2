# frozen_string_literal: true

class AddExpiresAtColumnToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :design_stage_expires_at, :datetime
    add_column :projects, :finalist_stage_expires_at, :datetime
    add_column :projects, :files_stage_expires_at, :datetime
    add_column :projects, :review_files_stage_expires_at, :datetime

    execute(
      <<-SQL
        UPDATE projects
        SET design_stage_expires_at = design_stage_started_at + CASE projects.project_type
                                                                WHEN #{Project.project_types[:logo]} THEN INTERVAL '#{Project::LOGO_DESIGN_STAGE_EXPIRE_TIME.inspect}'
                                                                WHEN #{Project.project_types[:brand_identity]} THEN INTERVAL '#{Project::BRAND_IDENTITY_DESIGN_STAGE_EXPIRE_TIME.inspect}'
                                                                WHEN #{Project.project_types[:packaging]} THEN INTERVAL '#{Project::PACKAGING_DESIGN_STAGE_EXPIRE_TIME.inspect}'
                                                                END,
            finalist_stage_expires_at = finalist_stage_started_at + CASE projects.project_type
                                                                    WHEN #{Project.project_types[:logo]} THEN INTERVAL '#{Project::LOGO_FINALIST_STAGE_EXPIRE_TIME.inspect}'
                                                                    WHEN #{Project.project_types[:brand_identity]} THEN INTERVAL '#{Project::BRAND_IDENTITY_FINALIST_STAGE_EXPIRE_TIME.inspect}'
                                                                    WHEN #{Project.project_types[:packaging]} THEN INTERVAL '#{Project::PACKAGING_FINALIST_STAGE_EXPIRE_TIME.inspect}'
                                                                    END,
            files_stage_expires_at = files_stage_started_at + INTERVAL '#{Project::FILES_STAGE_EXPIRE_TIME.inspect}',
            review_files_stage_expires_at = review_files_stage_started_at + INTERVAL '#{Project::REVIEW_FILES_STAGE_EXPIRE_TIME.inspect}'
      SQL
    )
  end
end
