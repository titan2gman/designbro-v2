# frozen_string_literal: true

Blueprinter.configure do |config|
  # config.default_transformers = [CamelCaseTransformer]
  config.generator = Oj # default is JSON
end
