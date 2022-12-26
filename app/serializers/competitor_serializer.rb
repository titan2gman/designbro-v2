# frozen_string_literal: true

class CompetitorSerializer < ActiveModel::Serializer
  attributes :url,
             :name,
             :rate,
             :website,
             :comment,
             :uploaded_file_id

  def url
    object.competitor_logo.file.url
  end

  def uploaded_file_id
    object.competitor_logo.id.to_s
  end

  def rate
    object.rate || 0
  end

  def name
    object.name || ''
  end

  def website
    object.website || ''
  end

  def comment
    object.comment || ''
  end
end
