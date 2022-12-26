# frozen_string_literal: true

class DesignerMailer < ApplicationMailer
  # designer info

  def portfolio_approved(user:)
    mail(to: user.email)
  end

  def portfolio_disapproved(user:)
    @designer = user.designer

    mail(to: user.email)
  end

  def spot_reserved(spot:)
    @designer = spot.designer
    @project = spot.project

    mail(to: @designer.email, subject: "Great! You got your spot for #{@project.name}!")
  end

  def one_to_one_project_started(project:)
    @project = project
    @designer = @project.spots.first.designer

    mail(to: @designer.email)
  end

  def one_to_one_project_reminder(project:)
    @project = project
    @designer = @project.spots.first.designer

    mail(
      to: @designer.email,
      subject: default_i18n_subject(product_name: @project.product_name, brand_name: @project.brand_name)
    )
  end

  def design_approved(project:)
    @project = project
    @designer = @project.spots.first.designer

    mail(
      to: @designer.email,
      subject: default_i18n_subject(product_name: @project.product_name, brand_name: @project.brand_name)
    )
  end

  # warnings

  def reservation_12_hours_left(user:, project:)
    @resource = user
    @project = project

    mail(to: @resource.email)
  end

  def files_stage_two_days_left(project:)
    @project = project

    mail(to: @project.winner.email)
  end

  def files_stage_one_day_left(project:)
    @project = project

    mail(to: @project.winner.email)
  end

  # state changed

  def selected_as_finalist(user:, project:)
    @resource = user
    @project = project

    mail(to: @resource.email)
  end

  def selected_as_finalist_for_brand_identity(user:, project:)
    @resource = user
    @project = project

    mail(to: @resource.email)
  end

  def selected_as_winner(project:)
    @project = project

    mail(to: @project.winner.email)
  end

  def design_eliminated(design:)
    @project = design.project
    @designer = design.designer
    @reason_message = design.eliminate_reason

    mail(to: @designer.email)
  end

  def design_not_selected_as_finalist(design:)
    @project = design.project
    @designer = design.designer

    mail(to: @designer.email)
  end

  def design_not_selected_as_winner(design:)
    @project = design.project
    @designer = design.designer

    mail(to: @designer.email)
  end

  def designer_blocked(design:, reason:)
    @project = design.project
    @designer = design.designer
    @reason_message = reason

    mail(to: @designer.email)
  end

  def contest_completed(project:)
    @project = project

    mail(to: project.winner.email)
  end

  # time out

  def design_stage_time_out(user:, project:)
    @project = project

    mail(to: user.email)
  end

  def finalist_stage_time_out(user:, project:)
    @project = project

    mail(to: user.email)
  end

  def files_stage_time_out(project:)
    @project = project

    mail(to: @project.winner.email)
  end
end
