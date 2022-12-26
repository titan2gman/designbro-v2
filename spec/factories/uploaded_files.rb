# frozen_string_literal: true

path = File.join(Rails.root, 'spec', 'factories', 'files', 'test.png')

FactoryBot.define do
  factory :uploaded_file do
    file { Rack::Test::UploadedFile.new(path) }

    factory :design_file,             class: UploadedFile::DesignFile
    factory :designer_portfolio_work, class: UploadedFile::DesignerPortfolioWork
    factory :brand_example,           class: UploadedFile::BrandExample
    factory :existing_logo,           class: UploadedFile::ExistingLogo
    factory :competitor_logo,         class: UploadedFile::CompetitorLogo
    factory :inspiration_image,       class: UploadedFile::InspirationImage
    factory :technical_drawing,       class: UploadedFile::TechnicalDrawing
    factory :additional_document,     class: UploadedFile::AdditionalDocument
    factory :stock_image,             class: UploadedFile::StockImage
    factory :source_file,             class: UploadedFile::SourceFile
    factory :portfolio_image_file,    class: UploadedFile::PortfolioImageFile
  end
end
