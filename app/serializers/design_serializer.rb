# frozen_string_literal: true

class DesignSerializer < ActiveModel::Serializer
  attributes :name,
             :rating,
             :image,
             :image_id,
             :banned,
             :finalist,
             :created_at,
             :designer_name,
             :winner,
             :state

  belongs_to :spot

  has_one :project
  has_one :designer

  # remove it
  def image_id
    object.uploaded_file.id
  end

  # remove it
  def image
    object.uploaded_file.file_url
  end

  # rename it
  def banned
    DesignerClientBlock.where(
      designer: object.designer,
      client: object.project.company.clients
    ).any? && !finalist && !winner
  end

  # remove
  def designer_name
    object.designer.display_name
  end

  # remove
  def finalist
    object.finalist?
  end

  # remove
  def winner
    object.winner?
  end

  # WTF?
  def name
    object.name.chomp(".#{object.uploaded_file.file.file.extension}")
  end
end
