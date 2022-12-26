# frozen_string_literal: true

ActiveModelSerializers.config.adapter = :json_api
ActiveModelSerializers.config.key_transform = :camel_lower
ActiveModelSerializers.config.jsonapi_pagination_links_enabled = false
