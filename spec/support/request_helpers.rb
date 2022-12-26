# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def data
      json['data']
    end
  end
end
