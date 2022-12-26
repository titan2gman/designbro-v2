# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def new_chat_message_created(message:)
    return unless message

    @message   = message
    @sender    = message.user
    @design    = message.design
    @addressee = message.addressee
    @project   = @design.project

    mail(to: @addressee.email, subject: default_i18n_subject(
      sender: @sender.display_name, project: @project.name
    ))
  end

  def google_plus_functionality_removed(user:)
    @full_name = user.name

    mail(to: user.email)
  end
end
