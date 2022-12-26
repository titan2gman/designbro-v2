# frozen_string_literal: true

class TechnicalDrawingUploader < FileUploader
  def extension_whitelist
    ['jpg', 'jpeg', 'png', 'ai', 'eps', 'pdf']
  end
end
