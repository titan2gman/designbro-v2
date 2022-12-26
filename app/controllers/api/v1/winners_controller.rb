# frozen_string_literal: true

module Api
  module V1
    class WinnersController < Api::V1::ApplicationController
      before_action :authenticate_client!

      load_and_authorize_resource :design

      serialization_scope :view_context

      def create
        form = WinnerForm.new(design: @design)

        return respond_with(form) unless form.valid?

        WinnerCreator.call(@design)

        respond_with @design, include: [:spot, :project]
      end
    end
  end
end
