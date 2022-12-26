# frozen_string_literal: true

class AdditionalDesignPriceBlueprint < Blueprinter::Base
  identifier :id

  fields :quantity, :amount

  transform CamelCaseTransformer
end
