# frozen_string_literal: true

class SupportMailer < ApplicationMailer
  if Rails.env.production?
    default to: 'support@designbro.com'
  else
    default to: 'staging-support@designbro.com'
  end

  def design_stage_time_out(project:)
    @client = project.clients.first
    @designers = project.designers
    @payment_type = project.payments.first&.payment_type

    mail
  end

  def finalist_stage_time_out(project:)
    @client = project.clients.first
    @designers = project.finalists
    @payment_type = project.payments.first&.payment_type

    mail
  end

  def files_stage_time_out(project:)
    file = project.spots.winner.first.design.uploaded_file.file.file.read

    attachments['design.png'] = file

    @client = project.clients.first
    @winner = project.winner

    mail
  end

  def new_feedback_created_mail(feedback)
    subject = feedback.subject

    @name    = feedback.name
    @email   = feedback.email
    @message = feedback.message

    mail(subject: subject)
  end
end
