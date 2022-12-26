# frozen_string_literal: true

module Api
  module V1
    class FeaturedImagesController < Api::V1::ApplicationController
      before_action :initialize_uploaded_file, only: [:create]
      before_action :find_featured_image, only: [:destroy]

      load_resource :project
      load_and_authorize_resource

      def create
        return respond_with @featured_image unless @featured_image.save

        respond_with @file
      end

      def destroy
        @featured_image.destroy

        return head :internal_server_error unless @featured_image.destroyed?

        head :ok
      end

      private

      def find_featured_image
        @featured_image = FeaturedImage.joins(:uploaded_featured_image).find_by! uploaded_files: { id: params[:id] }
      end

      def initialize_uploaded_file
        @file = UploadedFile::UploadedFeaturedImage.new file: params[:file]
      end

      def featured_image_params
        { uploaded_featured_image: @file, project_id: params[:project_id] }
      end
    end
  end
end
