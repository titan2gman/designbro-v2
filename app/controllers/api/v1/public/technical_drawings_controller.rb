# frozen_string_literal: true

module Api
  module V1
    module Public
      class TechnicalDrawingsController < Api::V1::ApplicationController
        load_and_authorize_resource class: 'UploadedFile::TechnicalDrawing'

        def create
          @technical_drawing.save

          respond_with @technical_drawing
        end

        private

        def technical_drawing_params
          params.permit(:file).merge(type: 'UploadedFile::TechnicalDrawing')
        end
      end
    end
  end
end
