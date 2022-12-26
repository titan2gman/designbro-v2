# frozen_string_literal: true

class SourceFileUploader < FileUploader
  def extension_whitelist
    ['png', 'jpg', 'pdf', 'ai', 'tiff', 'eps', 'psd', 'psb', 'ppt', 'pptx', 'doc', 'docx', 'svg', 'indd', 'ico', 'xd', 'mp4']
  end
end
