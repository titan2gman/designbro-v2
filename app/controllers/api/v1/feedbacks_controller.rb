# frozen_string_literal: true

module Api
  module V1
    class FeedbacksController < Api::V1::ApplicationController
      load_resource

      def create
        feedback_saved_successfully = @feedback.save

        SupportMailer.new_feedback_created_mail(@feedback).deliver_later if feedback_saved_successfully

        respond_with @feedback
      end

      private

      def feedback_params
        params.require(:feedback).permit(
          :name,
          :email,
          :subject,
          :message
        )
      end
    end
  end
end
