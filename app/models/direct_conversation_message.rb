# frozen_string_literal: true

class DirectConversationMessage < ApplicationRecord
  include Wisper::Publisher

  belongs_to :user
  belongs_to :design

  has_many :message_attached_files, as: :entity, class_name: 'UploadedFile::MessageAttachedFile', validate: true, dependent: :destroy

  validates :user,   presence: true
  validates :design, presence: true

  validates :text, presence: true, length: { in: 1..2000 }

  def addressee
    if user.client?
      design.designer.user
    elsif user.designer?
      # FIXME: send to all clients
      design.project.company.clients.first.user
    end
  end
end
