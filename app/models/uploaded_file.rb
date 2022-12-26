# frozen_string_literal: true

class UploadedFile < ApplicationRecord
  belongs_to :entity, polymorphic: true, optional: true

  validates :file, presence: true

  before_update :send_to_log

  class DesignFile < self
    mount_uploader :file, DesignUploader

    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }
  end

  class DesignerPortfolioWork < self
    mount_uploader :file, DesignerPortfolioWorkUploader
    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }
  end

  class BrandExample < self
    mount_uploader :file, BrandExampleUploader
    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }

    has_many :project_brand_examples
  end

  class NewBrandExample < self
    mount_uploader :file, BrandExampleUploader
    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }

    has_many :project_brand_examples

    def self.policy_class
      NewBrandExamplePolicy
    end
  end

  class ExistingLogo < self
    mount_uploader :file, ExistingLogoUploader
    validates :file, file_size: { less_than_or_equal_to: 10.megabytes.to_i }
  end

  class CompetitorLogo < self
    mount_uploader :file, CompetitorLogoUploader
    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }
  end

  class InspirationImage < self
    mount_uploader :file, InspirationImageUploader
    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }
  end

  class TechnicalDrawing < self
    mount_uploader :file, TechnicalDrawingUploader
    validates :file, file_size: { less_than_or_equal_to: 10.megabytes.to_i }
  end

  class AdditionalDocument < self
    mount_uploader :file, AdditionalDocumentUploader
    validates :file, file_size: { less_than_or_equal_to: 25.megabytes.to_i }
  end

  class StockImage < self
    mount_uploader :file, StockImageUploader
    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }
  end

  class UploadedFeaturedImage < self
    mount_uploader :file, FeaturedImageUploader
    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }
  end

  class SourceFile < self
    mount_uploader :file, SourceFileUploader
  end

  class Avatar < self
    mount_uploader :file, AvatarUploader
  end

  class HeroImage < self
    mount_uploader :file, HeroImageUploader
  end

  class PortfolioImageFile < self
    mount_uploader :file, PortfolioImageUploader
    validates :file, file_size: { less_than_or_equal_to: 2.megabytes.to_i }
    before_destroy :check_entity

    private

    def check_entity
      raise 'Cannot delete while entity exists' if entity
    end
  end

  class MessageAttachedFile < self
    mount_uploader :file, MessageAttachedFileUploader
  end
  private

  def send_to_log
    Rails.logger.info("#{type} log old_entity_id is #{entity_id_was || 'null'} current record is #{inspect}")
  end
end
