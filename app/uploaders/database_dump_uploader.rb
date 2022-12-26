# frozen_string_literal: true

class DatabaseDumpUploader < FileUploader
  include Rails.application.routes.url_helpers

  def extension_whitelist
    ['gz']
  end

  def fog_authenticated_url_expiration
    10.minutes
  end

  def store_dir
    "database_dumps/#{model.id}"
  end
end
