# frozen_string_literal: true

module Api
  module V1
    class UploadedFilesController < Api::V1::ApplicationController
      before_action :authenticate_api_v1_user!

      FILE_TYPES = {
        'designer_portfolio_work': 'UploadedFile::DesignerPortfolioWork',
        'uploadedHeroImage': 'UploadedFile::HeroImage',
        'avatar': 'UploadedFile::Avatar'
      }.freeze

      load_and_authorize_resource

      def create
        @uploaded_file.save
        respond_with @uploaded_file
      end

      private

      def uploaded_file_params
        type = FILE_TYPES[params[:type]&.to_sym]
        raise ActiveRecord::RecordNotFound if type.nil?

        params.permit(:file, :remove_file).merge(type: type)
      end
    end
  end
end
