# frozen_string_literal: true

namespace :brand_examples do
  task seed: :environment do
    images = Dir.glob('db/data/examples/**/*')
    images.each do |image|
      UploadedFile::NewBrandExample.create!(
        file: File.open(image)
      )
    end
  end
end
