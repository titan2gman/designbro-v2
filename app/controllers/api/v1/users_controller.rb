# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      before_action :authenticate_api_v1_user!

      def update
        form = UserForm.new(update_params)
        form.save

        respond_with form.user.object
      end

      private

      def update_params
        params.require(:user).permit(
          :notify_news, :notify_messages_received, :notify_projects_updates,
          :inform_on_email, :email, :password, :approve
        ).to_h.merge(id: current_user.id)
      end
    end
  end
end
