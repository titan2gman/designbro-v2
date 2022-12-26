# frozen_string_literal: true

class DumpDatabaseJob < ApplicationJob
  def perform(admin_user_id)
    admin_user = AdminUser.find_by(id: admin_user_id)
    return unless admin_user

    dump_service = Databases::CreateDump.new
    dump_service.call

    if dump_service.success?
      AdminMailer.database_dump_done(admin_email: admin_user.email, database_dump_id: dump_service.database_dump.id)
                 .deliver_later
    else
      AdminMailer.database_dump_failed(admin_email: admin_user.email)
                 .deliver_later
    end
  end
end
