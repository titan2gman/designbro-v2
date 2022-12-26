# frozen_string_literal: true

module Api
  module V1
    module Designers
      class ProjectsController < Api::V1::ApplicationController
        serialization_scope :view_context

        before_action :authenticate_designer!

        load_and_authorize_resource

        def index
          projects = case params[:scope]
                     when 'in-progress' then DesignerProjectsQuery::InProgress.call(@projects)
                     when 'completed'   then DesignerProjectsQuery::Completed.call(@projects)
                     else @projects
                     end

          respond_with projects.order(created_at: :desc), each_serializer: DesignerProjectSerializer, include: '**'
        end

        def search
          @projects = SearchedDesignerProjectsQuery.new(discover_query_params).search.page(params[:page]).per(10)

          respond_with @projects, each_serializer: DesignerProjectSerializer, meta: pagination_data(@projects), include: '**'
        end

        private

        def discover_query_params
          projects = @projects.discover
          sort_params = params.permit(:sort).fetch(:sort, '').split(',')

          search_params = params.permit(
            :name_cont,
            :product_category_id,
            state_not_in: []
          )

          {
            projects: projects,
            sort_params: sort_params,
            search_params: search_params,
            spots_state: params[:spots_state]
          }
        end
      end
    end
  end
end
