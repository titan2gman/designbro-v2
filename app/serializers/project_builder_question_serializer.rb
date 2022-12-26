# frozen_string_literal: true

class ProjectBuilderQuestionSerializer < ActiveModel::Serializer
  attributes :id,
             :attribute_name,
             :component_name,
             :props,
             :validations,
             :position,
             :project_builder_step_id,
             :product_id,
             :mandatory
end
