# frozen_string_literal: true

module Api
  module V1
    class ProjectSourceFilesController < Api::V1::ApplicationController
      include Zipline

      before_action :initialize_uploaded_file, only: [:create]

      serialization_scope :view_context

      load_and_authorize_resource :project
      load_and_authorize_resource through: :project, only: [:index, :destroy]

      def index
        @project_source_files = @project_source_files.includes(:source_file)

        respond_to do |format|
          format.json { respond_with @project_source_files }
          format.zip do
            source_files = @project_source_files.map(&:source_file)

            files = ZipArchiver.call(source_files)

            zipline(files, "#{@project.name}.zip")
          end
        end
      end

      def create
        form = SourceFileForm.new(project_source_file_params)
        form.save

        respond_with form.project_source_file, include: :project
      end

      def destroy
        @project_source_file.destroy

        return head :internal_server_error unless @project_source_file.destroyed?

        head :ok
      end

      private

      def initialize_uploaded_file
        @file = UploadedFile::SourceFile.new file: params[:file]
      end

      def project_source_file_params
        { designer: designer, source_file: @file, project: @project }
      end
    end
  end
end
