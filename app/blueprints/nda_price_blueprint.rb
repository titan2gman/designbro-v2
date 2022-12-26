# frozen_string_literal: true

class NdaPriceBlueprint < Blueprinter::Base
  identifier :id

  fields :nda_type, :price

  transform CamelCaseTransformer
end
