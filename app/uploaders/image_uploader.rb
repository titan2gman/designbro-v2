# frozen_string_literal: true

class ImageUploader < FileUploader
  def extension_whitelist
    ['jpg', 'jpeg', 'png', 'svg']
  end
end
