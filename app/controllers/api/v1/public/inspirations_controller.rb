# frozen_string_literal: true

module Api
  module V1
    module Public
      class InspirationsController < Api::V1::ApplicationController
        before_action :initialize_uploaded_file, only: [:create]
        before_action :find_inspiration, only: [:destroy]

        load_resource :project
        load_and_authorize_resource

        def create
          return respond_with @inspiration unless @inspiration.save

          respond_with @file
        end

        def destroy
          @inspiration.destroy

          return head :internal_server_error unless @inspiration.destroyed?

          head :ok
        end

        private

        def find_inspiration
          @inspiration = Inspiration.joins(:inspiration_image).find_by!(uploaded_files: { id: params[:id] })
        end

        def initialize_uploaded_file
          @file = UploadedFile::InspirationImage.new file: params[:file]
        end

        def inspiration_params
          { inspiration_image: @file, project: @project }
        end
      end
    end
  end
end
