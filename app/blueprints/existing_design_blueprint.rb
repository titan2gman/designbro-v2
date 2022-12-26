# frozen_string_literal: true

class ExistingDesignBlueprint < Blueprinter::Base
  identifier :id

  view :project_builder do
    fields :comment

    field :preview_url do |existing_design|
      existing_design.existing_logo.file.url
    end

    field :original_filename do |existing_design|
      existing_design.existing_logo.original_filename
    end

    transform CamelCaseTransformer
  end
end
