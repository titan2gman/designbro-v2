# frozen_string_literal: true

module Api
  module V1
    class FaqGroupsController < Api::V1::ApplicationController
      load_and_authorize_resource

      def index
        respond_with @faq_groups, include: '**'
      end
    end
  end
end
