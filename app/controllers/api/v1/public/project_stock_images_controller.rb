# frozen_string_literal: true

module Api
  module V1
    module Public
      class ProjectStockImagesController < Api::V1::ApplicationController
        before_action :initialize_uploaded_file, only: [:create]
        before_action :find_project_stock_image, only: [:destroy]

        load_resource :project
        load_and_authorize_resource

        def create
          return respond_with @project_stock_image unless @project_stock_image.save

          respond_with @file
        end

        def destroy
          @project_stock_image.destroy

          return head :internal_server_error unless @project_stock_image.destroyed?

          head :ok
        end

        private

        def find_project_stock_image
          @project_stock_image = ProjectStockImage.joins(:stock_image).find_by!(uploaded_files: { id: params[:id] })
        end

        def initialize_uploaded_file
          @file = UploadedFile::StockImage.new(file: params[:file])
        end

        def project_stock_image_params
          {
            stock_image: @file,
            project_id: params[:project_id]
          }
        end
      end
    end
  end
end
