# frozen_string_literal: true

module Api
  module V1
    class SpotsController < Api::V1::ApplicationController
      serialization_scope :view_context

      before_action :authenticate_api_v1_user!

      load_and_authorize_resource :project
      load_and_authorize_resource

      def create
        form = ReserveSpotForm.new(object: @spot)
        form.save

        respond_with form.spot, include: :project
      end

      private

      def spot_params
        { project: @project }
      end
    end
  end
end
