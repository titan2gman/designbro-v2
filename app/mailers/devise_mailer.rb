# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  layout 'mailer'

  include Devise::Controllers::UrlHelpers
  add_template_helper(EmailsHelper)

  default template_path: 'devise/mailer'

  def password_changed(user)
    mail(to: user.email, subject: I18n.t('devise.mailer.password_changed.subject'))
  end
end
