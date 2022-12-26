# frozen_string_literal: true

class ProductBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :key, :price, :product_category_name

  association :additional_design_prices, blueprint: AdditionalDesignPriceBlueprint

  view :project_builder do
    association :project_builder_steps, blueprint: ProjectBuilderStepBlueprint

    transform CamelCaseTransformer
  end

  view :attributes do
    transform CamelCaseTransformer
  end
end
