# frozen_string_literal: true

class VatRateBlueprint < Blueprinter::Base
  identifier :id

  fields :country_name, :country_code, :percent

  transform CamelCaseTransformer
end
