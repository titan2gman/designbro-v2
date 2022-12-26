# frozen_string_literal: true

module Api
  module V1
    module Auth
      class DevisePasswordsController < DeviseTokenAuth::PasswordsController
        private

        def render_update_success
          DeviseMailer.password_changed(@resource).deliver_later

          render json: {
            success: true,
            data: resource_data,
            message: I18n.t('devise_token_auth.passwords.successfully_updated')
          }
        end

        def resource_errors
          @resource.errors.messages.map { |error| [error[0], @resource.errors.full_messages_for(error[0])] }.to_h
        end
      end
    end
  end
end
