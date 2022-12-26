# frozen_string_literal: true

class MessageAttachedFileUploader < FileUploader
  def extension_whitelist
    ['jpg', 'jpeg', 'png', 'pdf', 'docx', 'doc', 'pptx', 'ppt', 'sketch', 'ai', 'indd', 'psd', 'eps', 'tiff', 'svg', 'gif']
  end
end
