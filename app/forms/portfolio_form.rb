# frozen_string_literal: true

class PortfolioForm < BaseForm
  presents :designer

  attribute :portfolio_works, Array

  private

  def persist!
    designer.portfolio_works = works
    designer.portfolio_uploaded = true
    designer.save!

    product_category_ids = portfolio_works.map { |work| work[:product_category_id] }.uniq

    designer.designer_experiences.where(product_category_id: product_category_ids).find_each do |exp|
      exp.upload_works! if exp.draft?
    end
  end

  def works
    @works ||= portfolio_works.map do |pw|
      PortfolioWork.new(
        product_category_id: pw[:product_category_id],
        description: pw[:description],
        uploaded_file: UploadedFile::DesignerPortfolioWork.find(pw[:uploaded_file_id])
      )
    end
  end
end
