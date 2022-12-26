# frozen_string_literal: true

schema_directory = "#{Rails.root}/spec/support/api/schemas"

RSpec::Matchers.define :match_response_schema do |schema, options = { strict: false }|
  match do |response|
    schema_file_path = "#{schema_directory}/#{schema}.json"

    JSON::Validator.validate!(
      schema_file_path,
      response.body,
      options
    )
  end
end
