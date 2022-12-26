# frozen_string_literal: true

class ClientMailer < ApplicationMailer
  # payments

  def one_to_one_payment_received(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def bank_transfer_payment_received(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def payment_received(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def not_paid_project(project:)
    @project = project
    mail(
      to: @project.clients.map(&:email),
      subject: default_i18n_subject(brand_name: @project.brand_name)
    )
  end

  def time_to_approve_project(project:)
    @project = project
    mail(
      to: @project.clients.map(&:email),
      subject: default_i18n_subject(product_name: @project.product_name, brand_name: @project.brand_name)
    )
  end

  def time_to_approve_project_reminder(project:)
    @project = project
    mail(
      to: @project.clients.map(&:email),
      subject: default_i18n_subject(product_name: @project.product_name, brand_name: @project.brand_name)
    )
  end

  def design_approved(project:)
    @project = project
    mail(
      to: @project.clients.map(&:email),
      subject: default_i18n_subject(product_name: @project.product_name, brand_name: @project.brand_name)
    )
  end

  def all_done(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def more_work(project:)
    @project = project
    @product_options = Product.one_to_one_recommentations(project)

    mail(
      to: @project.clients.map(&:email),
      subject: default_i18n_subject(designer_name: @project.winner.display_name)
    )
  end

  # warnings

  def design_stage_three_days_left(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def design_stage_one_day_left(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def finalist_stage_two_days_left(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def finalist_stage_one_day_left(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def review_files_stage_three_days_left(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  # time out

  def design_stage_time_out(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def finalist_stage_time_out(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def files_stage_time_out(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def file_auto_approve(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  # state changes

  def one_to_one_project_started(project:)
    @project = project
    mail(
      to: @project.clients.map(&:email),
      subject: default_i18n_subject(product_name: @project.product_name, brand_name: @project.brand_name)
    )
  end

  def finalist_stage_started(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def brand_identity_finalist_stage_started(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def review_files_stage_started(project:)
    @time_left = ((project.review_files_stage_expires_at - Time.current) / 1.day).round
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  # file upload

  def new_source_file_uploaded(project:)
    @project = project
    mail(to: @project.clients.map(&:email))
  end

  def new_design_uploaded(design:)
    @design  = design
    @project = @design.project
    @clients = @project.clients

    mail(to: @clients.map(&:email))
  end
end
