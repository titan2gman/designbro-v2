# frozen_string_literal: true

class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  include Rails.application.routes.url_helpers

  before :cache, :save_original_filename

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  private

  def save_original_filename(file)
    model.original_filename ||= file.original_filename if file.respond_to?(:original_filename)
  end

  def secure_token
    value = SecureRandom.uuid
    name  = :"@#{mounted_as}_secure_token"

    model.instance_variable_get(name) || model.instance_variable_set(name, value)
  end
end
