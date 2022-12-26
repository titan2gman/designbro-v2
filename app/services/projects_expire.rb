# frozen_string_literal: true

class ProjectsExpire
  include Wisper::Publisher

  def call
    expire_design_stage_projects
    expire_finalist_stage_projects
    expire_files_stage_projects
    expire_review_files_stage_projects
  end

  private

  def expire_design_stage_projects
    Project.design_stage.each do |project|
      if project.design_stage_expired?
        if project.finalist_count_enough_for_finalist_stage?
          project.finalist_stage!
        else
          project.error!
        end
      elsif project.send_three_days_of_design_stage_left_warning?
        broadcast(:design_stage_three_days_left, project)
      elsif project.send_one_day_of_design_stage_left_warning?
        broadcast(:design_stage_one_day_left, project)
      end
    end
  end

  def expire_finalist_stage_projects
    Project.finalist_stage.each do |project|
      project.error! if project.finalist_stage_expired?

      broadcast(:finalist_stage_two_days_left, project) if project.send_two_days_of_finalist_stage_left_warning?
      broadcast(:finalist_stage_one_day_left, project) if project.send_one_day_of_finalist_stage_left_warning?
    end
  end

  def expire_files_stage_projects
    Project.files_stage.each do |project|
      if project.files_stage_expired?
        project.error!
      elsif project.send_two_days_of_files_stage_left_warning?
        broadcast(:files_stage_two_days_left, project)
      elsif project.send_one_day_of_files_stage_left_warning?
        broadcast(:files_stage_one_day_left, project)
      end
    end
  end

  def expire_review_files_stage_projects
    Project.review_files.each do |project|
      if project.review_files_expired?
        project.approve_files!
        EarningCreator::PayWinner.call(project)
        broadcast(:file_auto_approve, project)
      elsif project.send_three_days_of_review_files_stage_left_warning?
        broadcast(:review_files_stage_three_days_left, project)
      end
    end
  end
end
