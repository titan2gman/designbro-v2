# frozen_string_literal: true

class FaqGroupSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :faq_items
end
