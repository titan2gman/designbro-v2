# frozen_string_literal: true

class DesignerPortfolioSettingsForm < BaseForm
  presents :designer

  attribute :one_to_one_available, Boolean
  attribute :description, String
  attribute :languages, Array
  attribute :avatar_id, Integer
  attribute :uploaded_hero_image_id, Integer

  private

  def persist!
    ActiveRecord::Base.transaction do
      designer.update(params)
    end
  end

  def params
    {
      one_to_one_available: one_to_one_available,
      description: description,
      languages: languages
    }.compact.merge(
      avatar: avatar_uploaded_file,
      uploaded_hero_image: uploaded_hero_image_uploaded_file
    )
  end

  def avatar_uploaded_file
    avatar_id && UploadedFile::Avatar.find(avatar_id)
  end

  def uploaded_hero_image_uploaded_file
    uploaded_hero_image_id && UploadedFile::HeroImage.find(uploaded_hero_image_id)
  end
end
