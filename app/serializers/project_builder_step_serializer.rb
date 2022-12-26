# frozen_string_literal: true

class ProjectBuilderStepSerializer < ActiveModel::Serializer
  attributes :id,
             :path,
             # :mandatory_for_one_to_one_project,
             # :mandatory_for_existing_brand,
             :authentication_required,
             :name,
             :description,
             :position,
             :product_id

  has_many :project_builder_questions
end
