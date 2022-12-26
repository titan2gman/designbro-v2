# frozen_string_literal: true

module Api
  module V1
    class DesignerStatsController < Api::V1::ApplicationController
      before_action :authenticate_designer!
      authorize_resource :designer

      def show
        respond_with DesignerStats.new(designer)
      end
    end
  end
end
