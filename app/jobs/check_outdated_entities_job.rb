# frozen_string_literal: true

class CheckOutdatedEntitiesJob < ApplicationJob
  TYPES_FOR_DELETION = ['UploadedFile::ExistingLogo', 'UploadedFile::CompetitorLogo', 'UploadedFile::InspirationImage', 'UploadedFile::TechnicalDrawing', 'UploadedFile::AdditionalDocument', 'UploadedFile::DesignerPortfolioWork'].freeze

  queue_as :default

  def perform
    UploadedFile
      .where(type: TYPES_FOR_DELETION)
      .where(entity: nil).where('updated_at < ?', 3.week.ago)
      .destroy_all
  end
end
