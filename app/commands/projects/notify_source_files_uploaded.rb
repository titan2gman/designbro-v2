# frozen_string_literal: true

module Projects
  class NotifySourceFilesUploaded
    NOTIFY_PERIOD = 10

    def call
      projects.each do |project|
        ClientMailer.review_files_stage_started(project: project).deliver_later
      end
    end

    private

    def projects
      @projects ||= Project.joins(project_source_files: :source_file)
                           .where(projects: { state: project_states })
                           .where(uploaded_files: { created_at: period_range })
                           .distinct
    end

    def period_range
      @period_range ||= begin
        current_time = Time.current
        (current_time - NOTIFY_PERIOD.minutes)..current_time
      end
    end

    def project_states
      [
        Project::STATE_FILES_STAGE,
        Project::STATE_REVIEW_FILES
      ]
    end
  end
end
