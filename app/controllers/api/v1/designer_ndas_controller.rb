# frozen_string_literal: true

module Api
  module V1
    class DesignerNdasController < Api::V1::ApplicationController
      before_action :authenticate_designer!

      load_and_authorize_resource

      serialization_scope :view_context

      def index
        @designer_ndas = @designer_ndas.order(created_at: :desc).page(params[:page]).per(5)

        meta = pagination_data @designer_ndas

        respond_with @designer_ndas, include: '**', meta: meta
      end

      def create
        @designer_nda.save

        respond_with @designer_nda
      end

      private

      def designer_nda_params
        params.permit(:nda_id)
      end
    end
  end
end
