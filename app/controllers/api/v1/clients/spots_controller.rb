# frozen_string_literal: true

module Api
  module V1
    module Clients
      class SpotsController < Api::V1::ApplicationController
        serialization_scope :view_context

        before_action :authenticate_client!

        def finalists
          @finalists = FinalistsQuery.new(client).call

          respond_with @finalists, each_serializer: FinalistSerializer
        end
      end
    end
  end
end
