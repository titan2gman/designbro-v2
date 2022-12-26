# frozen_string_literal: true

module Api
  module V1
    module Public
      class CompetitorsController < Api::V1::ApplicationController
        before_action :initialize_uploaded_file, only: [:create]
        before_action :initialize_competitor, only: [:destroy]

        load_resource :brand
        load_and_authorize_resource

        def create
          return respond_with @competitor unless @competitor.save

          respond_with @file
        end

        def destroy
          @competitor.destroy

          return head :internal_server_error unless @competitor.destroyed?

          render json: @competitor
        end

        private

        def initialize_competitor
          @competitor = Competitor.joins(:competitor_logo).find_by!(uploaded_files: { id: params[:id] })
        end

        def initialize_uploaded_file
          @file = UploadedFile::CompetitorLogo.new file: params[:file]
        end

        def competitor_params
          { competitor_logo: @file, brand: @brand }
        end
      end
    end
  end
end
