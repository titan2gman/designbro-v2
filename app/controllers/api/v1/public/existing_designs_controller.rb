# frozen_string_literal: true

module Api
  module V1
    module Public
      class ExistingDesignsController < Api::V1::ApplicationController
        before_action :initialize_uploaded_file, only: [:create]
        before_action :find_existing_design, only: [:destroy]

        load_resource :project
        load_and_authorize_resource

        def create
          return respond_with @existing_design unless @existing_design.save

          respond_with @file
        end

        def destroy
          @existing_design.destroy

          return head :internal_server_error unless @existing_design.destroyed?

          head :ok
        end

        private

        def find_existing_design
          @existing_design = ExistingDesign.joins(:existing_logo).find_by!(uploaded_files: { id: params[:id] })
        end

        def initialize_uploaded_file
          @file = UploadedFile::ExistingLogo.new(file: params[:file])
        end

        def existing_design_params
          { existing_logo: @file, project: @project }
        end
      end
    end
  end
end
