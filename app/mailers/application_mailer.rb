# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  add_template_helper(EmailsHelper)
end
