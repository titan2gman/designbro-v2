# frozen_string_literal: true

module Api
  module V1
    class BrandsController < Api::V1::ApplicationController
      serialization_scope :view_context

      before_action :authenticate_api_v1_user!

      load_and_authorize_resource

      def index
        brands = BrandsQuery.new(@brands).search(search_params).page(params[:page]).per(11)

        respond_with brands, meta: pagination_data(brands), each_serializer: BrandAttributesSerializer
      end

      def all
        brands = BrandsQuery.new(@brands).all

        respond_with brands, each_serializer: BrandAttributesSerializer
      end

      def show
        respond_with @brand, serializer: BrandWithProjectsSerializer, include: '**'
      end

      private

      def search_params
        params.permit(
          :name_cont
        )
      end
    end
  end
end
