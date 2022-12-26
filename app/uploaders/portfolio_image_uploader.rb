# frozen_string_literal: true

class PortfolioImageUploader < ImageUploader
  version :thumb do
    process resize_to_fill: [280, 280]
  end

  version :small do
    process resize_to_fill: [60, 60]
  end
end
