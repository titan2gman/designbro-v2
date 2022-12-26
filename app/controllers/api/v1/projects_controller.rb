# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < Api::V1::ApplicationController
      serialization_scope :view_context

      before_action :authenticate_api_v1_user!, only: [:update, :destroy, :search, :manual_request]

      load_and_authorize_resource

      before_action :check_params_id_for_designer, only: [:show]

      def show
        respond_with @project, include: '**'
      end

      def update
        form = ProjectForm.new(id: @project.id)
        form.subscribe(DesignerStatsListener.new)
        form.save

        respond_with form.project
      end

      def search
        @projects = SearchedClientProjectsQuery.new(query_params).search.page(params[:page]).per(10)
        respond_with @projects, meta: pagination_data(@projects)
      end

      def destroy
        @project.discard!

        head :ok
      end

      def manual_request
        IntercomConversationCreator.new(
          content: params[:content],
          email: client.email
        ).call

        head :ok
      end

      def upsell_spots
        @form = Upsell::AdditionalSpotsForm.new(upsell_params)
        @form.save

        respond_with @form.project, include: '**'
      end

      def upsell_days
        @form = Upsell::AdditionalDaysForm.new(upsell_params)
        @form.save

        respond_with @form.project, include: '**'
      end

      private

      def check_params_id_for_designer
        raise CanCan::AccessDenied if designer && params[:id].nil?
      end

      def query_params
        {
          projects: @projects,
          search_params: search_params
        }
      end

      def search_params
        params.permit(state_in: [])
      end

      def upsell_params
        params.require(:project).permit(
          :number_of_spots,
          :number_of_days,
          :payment_type,
          :discount_code,
          :payment_method_id, :payment_intent_id, :paypal_payment_id
        ).merge(
          id: params[:id],
          client: client
        )
      end
    end
  end
end
