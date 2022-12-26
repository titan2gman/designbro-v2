# frozen_string_literal: true

class DatabaseDump < ApplicationRecord
  mount_uploader :file, DatabaseDumpUploader
end
