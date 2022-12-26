# frozen_string_literal: true

module Admin
  module ImageHelper
    def image(uploader, type = :thumb)
      return content_tag(:span, 'no image yet') unless uploader&.file

      image_tag(uploader&.url, class: "#{type}-image")
    end
  end
end
