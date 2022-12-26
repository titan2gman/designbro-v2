# frozen_string_literal: true

class ReviewSerializer < ActiveModel::Serializer
  attributes :designer_rating,
             :designer_comment,
             :overall_rating,
             :overall_comment

  belongs_to :client
  belongs_to :design
  belongs_to :designer
end
