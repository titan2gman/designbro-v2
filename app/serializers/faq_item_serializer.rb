# frozen_string_literal: true

class FaqItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :answer

  belongs_to :faq_group
end
