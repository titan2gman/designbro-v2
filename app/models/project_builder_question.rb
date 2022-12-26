# frozen_string_literal: true

class ProjectBuilderQuestion < ApplicationRecord
  belongs_to :project_builder_step
  delegate :product_id, to: :project_builder_step

  acts_as_list scope: :project_builder_step

  COMPONENT_NAMES = [
    'Input',
    'Textarea',
    'Slider',
    'CountriesSelect',
    'Authentication',
    'BrandSelector',
    'OptionalBrandSelector',
    'ExistingDesigns',
    'ExistingLogos',
    'Competitors',
    'Inspirations',
    'AdditionalDocuments',
    'StockImages',
    'ColorsPicker',
    'Examples',
    'PackagingType',
    'Details',
    'Checkout'
  ].freeze

  INPUT_COMPONENT_PROPS_JSON_SCHEMA = Rails.root.join('lib', 'json_schemas', 'products', 'input_component_props.json_schema').to_s
  TEXTAREA_COMPONENT_PROPS_JSON_SCHEMA = Rails.root.join('lib', 'json_schemas', 'products', 'textarea_component_props.json_schema').to_s
  SLIDER_COMPONENT_PROPS_JSON_SCHEMA = Rails.root.join('lib', 'json_schemas', 'products', 'slider_component_props.json_schema').to_s

  validates :component_name, presence: true, inclusion: { in: COMPONENT_NAMES }

  validates :props, presence: true, json: { schema: INPUT_COMPONENT_PROPS_JSON_SCHEMA }, if: -> { component_name == 'Input' }
  validates :props, presence: true, json: { schema: TEXTAREA_COMPONENT_PROPS_JSON_SCHEMA }, if: -> { component_name == 'Textarea' }
  validates :props, presence: true, json: { schema: SLIDER_COMPONENT_PROPS_JSON_SCHEMA }, if: -> { component_name == 'Slider' }
end
