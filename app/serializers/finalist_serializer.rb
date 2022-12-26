# frozen_string_literal: true

class FinalistSerializer < ActiveModel::Serializer
  type 'finalist_designers'

  attributes :id,
             :display_name,
             :brand_name,
             :product_name,
             :spot_state,
             :created_at

  def created_at
    object.project_created_at.strftime('%b-%Y')
  end

  def spot_state
    object.spot_state.titleize
  end
end
