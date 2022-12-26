# frozen_string_literal: true

class DiscountBlueprint < Blueprinter::Base
  identifier :id

  fields :code, :discount_type, :value

  transform CamelCaseTransformer
end
