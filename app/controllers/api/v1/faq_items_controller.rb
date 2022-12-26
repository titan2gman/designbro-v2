# frozen_string_literal: true

module Api
  module V1
    class FaqItemsController < Api::V1::ApplicationController
      load_and_authorize_resource

      def show
        respond_with @faq_item, include: '**'
      end
    end
  end
end
