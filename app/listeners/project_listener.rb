# frozen_string_literal: true

class ProjectListener
  # payments

  def payment_received(project)
    ClientMailer.payment_received(project: project).deliver_later
  end

  def bank_transfer_payment_received(project)
    ClientMailer.bank_transfer_payment_received(project: project).deliver_later
  end

  # state changed

  def one_to_one_project_started(project)
    ClientMailer.one_to_one_project_started(project: project).deliver_later
    DesignerMailer.one_to_one_project_started(project: project).deliver_later
  end

  def finalist_stage_started(project)
    if project.brand_identity?
      ClientMailer.brand_identity_finalist_stage_started(project: project).deliver_later

      project.finalists.each do |designer|
        DesignerMailer.selected_as_finalist_for_brand_identity(user: designer.user, project: project).deliver_later
      end
    else
      ClientMailer.finalist_stage_started(project: project).deliver_later

      project.finalists.each do |designer|
        DesignerMailer.selected_as_finalist(user: designer.user, project: project).deliver_later
      end
    end

    project.spots.design_uploaded.each do |spot|
      DesignerMailer.design_not_selected_as_finalist(design: spot.design).deliver_later
    end
  end

  def files_stage_started(project)
    DesignerMailer.selected_as_winner(project: project).deliver_later
  end

  def review_files_stage_started(project)
    ClientMailer.review_files_stage_started(project: project).deliver_later
  end

  def contest_completed(project)
    DesignerMailer.contest_completed(project: project).deliver_later
    ClientMailer.more_work(project: project).deliver_later(wait: 2.hours)
  end

  def file_auto_approve(project)
    ClientMailer.file_auto_approve(project: project).deliver_later
  end

  def time_to_approve_project(project)
    ClientMailer.time_to_approve_project(project: project).deliver_later
  end

  def time_to_approve_project_reminder(project)
    ClientMailer.time_to_approve_project_reminder(project: project).deliver_later
  end

  def design_approved(project)
    ClientMailer.design_approved(project: project).deliver_later
    DesignerMailer.design_approved(project: project).deliver_later
  end

  def all_done(project)
    ClientMailer.all_done(project: project).deliver_later
  end

  def expire_project(project)
    if project.design_stage?
      project.designers.each do |designer|
        if has_active_spot?(project: project, designer: designer)
          DesignerMailer.design_stage_time_out(user: designer.user, project: project).deliver_later
        end
      end
      ClientMailer.design_stage_time_out(project: project).deliver_later if project.designs.empty?
      SupportMailer.design_stage_time_out(project: project).deliver_later

    elsif project.finalist_stage?
      project.finalists.each do |designer|
        if has_active_spot?(project: project, designer: designer)
          DesignerMailer.finalist_stage_time_out(user: designer.user, project: project).deliver_later
        end
      end
      ClientMailer.finalist_stage_time_out(project: project).deliver_later
      SupportMailer.finalist_stage_time_out(project: project).deliver_later

    elsif project.files_stage?
      DesignerMailer.files_stage_time_out(project: project).deliver_later
      ClientMailer.files_stage_time_out(project: project).deliver_later
      SupportMailer.files_stage_time_out(project: project).deliver_later
    end
  end

  # warnings

  def design_stage_three_days_left(project)
    ClientMailer.design_stage_three_days_left(project: project).deliver_later
  end

  def design_stage_one_day_left(project)
    ClientMailer.design_stage_one_day_left(project: project).deliver_later
  end

  def finalist_stage_two_days_left(project)
    ClientMailer.finalist_stage_two_days_left(project: project).deliver_later
  end

  def finalist_stage_one_day_left(project)
    ClientMailer.finalist_stage_one_day_left(project: project).deliver_later
  end

  def files_stage_two_days_left(project)
    DesignerMailer.files_stage_two_days_left(project: project).deliver_later
  end

  def files_stage_one_day_left(project)
    DesignerMailer.files_stage_one_day_left(project: project).deliver_later
  end

  def review_files_stage_three_days_left(project)
    ClientMailer.review_files_stage_three_days_left(project: project).deliver_later
  end

  def one_to_one_project_reminder(project)
    DesignerMailer.one_to_one_project_reminder(project: project).deliver_later
  end

  private

  def has_active_spot?(project:, designer:)
    project.spots.where(designer_id: designer.id).where.not(state: ['eliminated', 'deleted_by_admin']).any?
  end
end
