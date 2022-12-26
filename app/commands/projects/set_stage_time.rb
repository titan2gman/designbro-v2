# frozen_string_literal: true

module Projects
  class SetStageTime
    def initialize(project, stage_name)
      @project = project
      @stage_name = stage_name.to_s
    end

    def call
      project.update(
        "#{stage_name}_started_at": current_time,
        "#{stage_name}_expires_at": current_time + stage_expire_duration
      )
    end

    private

    attr_reader :project, :stage_name

    def current_time
      @current_time ||= Time.current
    end

    def stage_expire_duration
      project.public_send("#{stage_name}_expire_duration")
    end
  end
end
