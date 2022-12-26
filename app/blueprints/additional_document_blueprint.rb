# frozen_string_literal: true

class AdditionalDocumentBlueprint < Blueprinter::Base
  identifier :id

  view :project_builder do
    fields :comment

    field :preview_url do |existing_design|
      existing_design.additional_document.file.url
    end

    field :original_filename do |existing_design|
      existing_design.additional_document.original_filename
    end

    transform CamelCaseTransformer
  end
end
