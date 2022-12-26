# frozen_string_literal: true

class SpotSerializer < ActiveModel::Serializer
  attributes :state,
             :designer_name,
             :uploaded_file,
             :finalist,
             :created_at,
             :hours_to_expire

  has_one :design

  belongs_to :project
  belongs_to :designer

  def designer_name
    object.designer&.display_name
  end

  def finalist
    object.finalist?
  end

  def hours_to_expire
    ((object.reservation_expire_duration - (Time.zone.now - object.reserved_state_started_at).round) / 1.hour).floor if object.reserved?
  end
end
