# frozen_string_literal: true

class TestimonialSerializer < ActiveModel::Serializer
  attributes :header, :body, :rating, :credential, :company
end
