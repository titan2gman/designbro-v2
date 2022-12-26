# frozen_string_literal: true

module Api
  module V1
    module Designs
      class VersionsController < Api::V1::ApplicationController
        load_and_authorize_resource :design

        def index
          respond_with @design.design_versions, each_serializer: DesignVersionSerializer
        end
      end
    end
  end
end
