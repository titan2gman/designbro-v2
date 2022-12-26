# frozen_string_literal: true

class ProjectUploadedFileBlueprint < Blueprinter::Base
  identifier :id

  view :project_builder do
    fields :entity_id, :entity_type, :original_filename

    field :preview_url do |file|
      file.file.url
    end

    transform CamelCaseTransformer
  end
end
