# frozen_string_literal: true

class CompetitorBlueprint < Blueprinter::Base
  identifier :id

  view :project_builder do
    fields :comment

    field :preview_url do |competitor|
      competitor.competitor_logo.file.url
    end

    field :original_filename do |competitor|
      competitor.competitor_logo.original_filename
    end

    transform CamelCaseTransformer
  end
end
