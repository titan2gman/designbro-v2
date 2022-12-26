# frozen_string_literal: true

class NotifySourceFilesUploadedJob < ApplicationJob
  def perform
    Projects::NotifySourceFilesUploaded.new.call
  end
end
