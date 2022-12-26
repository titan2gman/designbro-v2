class BrandExample < ApplicationRecord
  belongs_to :project
  belongs_to :example, class_name: 'UploadedFile::NewBrandExample'
end
