# frozen_string_literal: true

module Api
  module V1
    class DesignsController < Api::V1::ApplicationController
      include ActionView::Helpers::TextHelper

      before_action :authenticate_api_v1_user!
      before_action :initialize_uploaded_file, only: [:create, :update]
      load_and_authorize_resource :project
      before_action :initialize_spot, only: [:create]
      authorize_resource :spot, only: [:create]

      serialization_scope :view_context

      load_and_authorize_resource through: :project, except: [:create]
      load_and_authorize_resource through: :client, only: [:block]
      authorize_resource only: [:create]

      before_action :initialize_design_form, only: [:create]
      before_action :initialize_update_form, only: [:update]

      def index
        respond_with @designs.not_eliminated
      end

      def show
        respond_with @design
      end

      def create
        @form.subscribe(DesignerStatsListener.new)
        @form.subscribe(DesignFormListener.new)
        @form.save

        respond_with @form.design
      end

      def update
        @form.subscribe(DesignerStatsListener.new)
        @form.subscribe(DesignFormListener.new)
        @form.update

        respond_with(@form.design, include: [:spot, :project])
      end

      def restore
        @design = @design.restore(params[:version_id])
        respond_with @design
      end

      def eliminate
        design = DesignEliminator.new(@design).call(eliminate_design_params)
        respond_with design, include: params[:include]
      end

      def block
        respond_with DesignerBlocker.new(design: @design, client: client).call(block_design_params), include: '**'
      end

      private

      def design_params
        params.require(:design).permit(
          :rating,
          :finalist,
          :stationery_approved
        ).to_h.merge(id: @design.id, project: @design.project)
      end

      def eliminate_design_params
        params.require(:design).permit(:eliminate_reason, :eliminate_custom_reason)
      end

      def block_design_params
        params.require(:design).permit(:block_reason, :block_custom_reason)
      end

      def initialize_uploaded_file
        @file = UploadedFile::DesignFile.new(file: params[:file]) if params[:file]
      end

      def initialize_spot
        authorize! :update, @project

        @spot = Spot.order(created_at: :desc).find_by(
          project: @project, designer: current_designer
        )
      end

      def initialize_design_form
        @form = DesignForm.new(
          uploaded_file: @file,
          project: @project,
          spot: @spot,
          name: truncate(@file.original_filename, length: 27)
        )
      end

      def initialize_update_form
        @form = if @file
                  DesignForm.new(
                    id: params[:id],
                    uploaded_file: @file,
                    name: truncate(@file.original_filename, length: 27),
                    project: @project
                  )
                else
                  DesignForm.new(design_params)
                end
      end
    end
  end
end
