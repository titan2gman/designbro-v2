# frozen_string_literal: true

module Api
  module V1
    module Public
      class ProjectAdditionalDocumentsController < Api::V1::ApplicationController
        before_action :initialize_uploaded_file, only: [:create]
        before_action :find_project_additional_document, only: [:destroy]

        load_resource :project
        load_and_authorize_resource

        def create
          return respond_with @project_additional_document unless @project_additional_document.save

          respond_with @file
        end

        def destroy
          @project_additional_document.destroy

          return head :internal_server_error unless @project_additional_document.destroyed?

          head :ok
        end

        private

        def find_project_additional_document
          @project_additional_document = ProjectAdditionalDocument.joins(:additional_document)
                                                                  .find_by! uploaded_files: { id: params[:id] }
        end

        def initialize_uploaded_file
          @file = UploadedFile::AdditionalDocument.new file: params[:file]
        end

        def project_additional_document_params
          { additional_document: @file, project_id: params[:project_id] }
        end
      end
    end
  end
end
