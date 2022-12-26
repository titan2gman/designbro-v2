# frozen_string_literal: true

class ExistingLogoUploader < FileUploader
  def extension_whitelist
    ['jpg', 'jpeg', 'png', 'ai', 'eps', 'pdf', 'psd', 'svg']
  end
end
