# frozen_string_literal: true

module Api
  module V1
    class ProjectExistingDesignsController < Api::V1::ApplicationController
      include Zipline

      load_and_authorize_resource :project

      def index
        @last_logo_project = @project.brand.projects.completed.joins(:product).where(products: { key: 'logo' }).order(created_at: :desc).first

        @existing_designs = if @last_logo_project
                              @last_logo_project.project_source_files.includes(:source_file).map(&:source_file)
                            else
                              @project.brand.existing_designs.includes(:existing_logo).map(&:existing_logo)
                            end

        respond_to do |format|
          format.zip do
            files = ZipArchiver.call(@existing_designs)

            zipline(files, "#{@project.name}.zip")
          end
        end
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
