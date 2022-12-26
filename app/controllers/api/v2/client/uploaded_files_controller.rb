# frozen_string_literal: true

module Api
  module V2
    module Client
      class UploadedFilesController < Api::V2::ApplicationController
        before_action :initialize_uploaded_file, only: [:create]

        def create
          entity = entity_class.new(entity_params)

          authorize entity

          entity.save!

          render json: ProjectUploadedFileBlueprint.render(@file, view: :project_builder)
        end

        private

        def initialize_uploaded_file
          @file = uploaded_file_class.create!(file: params[:file])
        end

        def uploaded_file_class
          class_names[params[:entity].to_sym][:uploaded_file_class]
        end

        def entity_class
          class_names[params[:entity].to_sym][:entity_class]
        end

        def class_names
          {
            existing_logo: {
              entity_class: ExistingDesign,
              uploaded_file_class: UploadedFile::ExistingLogo
            },
            competitor_logo: {
              entity_class: Competitor,
              uploaded_file_class: UploadedFile::CompetitorLogo
            },
            inspiration_image: {
              entity_class: Inspiration,
              uploaded_file_class: UploadedFile::InspirationImage
            },
            additional_document: {
              entity_class: ProjectAdditionalDocument,
              uploaded_file_class: UploadedFile::AdditionalDocument
            }
          }
        end

        def entity_params
          if brand_related_entity?
            { params[:entity] => @file, brand_id: Project.find(params[:project_id]).brand_id }
          else
            { params[:entity] => @file, project_id: params[:project_id] }
          end
        end

        def brand_related_entity?
          params[:entity] == 'competitor_logo'
        end
      end
    end
  end
end
