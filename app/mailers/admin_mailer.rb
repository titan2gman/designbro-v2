# frozen_string_literal: true

class AdminMailer < ApplicationMailer
  layout 'admin_mailer_layout'

  def database_dump_done(database_dump_id:, admin_email:)
    @database_dump_id = database_dump_id
    mail(to: admin_email, subject: I18n.t('admin_mailer.database_dump.done'))
  end

  def database_dump_failed(admin_email:)
    mail(to: admin_email, subject: I18n.t('admin_mailer.database_dump.failed'))
  end
end
