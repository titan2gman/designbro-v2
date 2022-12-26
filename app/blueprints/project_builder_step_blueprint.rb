# frozen_string_literal: true

class ProjectBuilderStepBlueprint < Blueprinter::Base
  identifier :id

  fields :component_name, :path, :position

  transform CamelCaseTransformer
end
