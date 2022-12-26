# frozen_string_literal: true

class DesignerExperienceSerializer < ActiveModel::Serializer
  attributes :id,
             :product_category_id,
             :experience,
             :state
end
