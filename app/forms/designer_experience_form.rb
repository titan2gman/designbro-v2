# frozen_string_literal: true

class DesignerExperienceForm < BaseForm
  presents :designer

  attribute :portfolio_works, Array
  attribute :experiences, Array

  private

  def persist!
    ActiveRecord::Base.transaction do
      save_portfolio_works
      save_designer_experiences
    end
  end

  def save_portfolio_works
    portfolio_works.each do |pw|
      work = pw[:id] ? designer.portfolio_works.find(pw[:id]) : designer.portfolio_works.new

      work.update!(
        product_category_id: pw[:product_category_id],
        description: pw[:description],
        uploaded_file: UploadedFile::DesignerPortfolioWork.find(pw[:uploaded_file_id])
      )
    end
  end

  def save_designer_experiences
    experiences.each do |e|
      experience = e[:id] ? designer.designer_experiences.find(e[:id]) : designer.designer_experiences.new
      experience.update!(
        product_category_id: e[:product_category_id],
        experience: e[:experience]
      )

      experience.upload_works! if (experience.disapproved? || experience.draft?) && new_works_uploaded_for?(e[:product_category_id])
    end
  end

  def new_works_uploaded_for?(product_category_id)
    portfolio_works.any? do |work|
      work[:product_category_id] == product_category_id && work[:new]
    end
  end
end
