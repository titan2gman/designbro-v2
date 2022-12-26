# frozen_string_literal: true

class AdditionalDocumentUploader < FileUploader
  def extension_whitelist
    ['jpg', 'jpeg', 'png', 'pdf', 'docx', 'doc', 'pptx', 'ppt', 'sketch', 'xd', 'ai', 'indd', 'psd', 'eps', 'txt', 'rtf', 'svg']
  end
end
