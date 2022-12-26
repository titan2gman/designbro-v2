# frozen_string_literal: true

module Api
  module V1
    module Auth
      class PasswordsController < Api::V1::ApplicationController
        def validate
          @resource = User.find_by(reset_password_token: params[:token])
          if @resource.present?
            render json: resource_data
          else
            render_unprocessable_entity_error
          end
        end

        def reset
          @resource = User.find_by(reset_password_token: params[:token])
          if @resource.present?
            return render_update_error_password_not_required unless @resource.provider == 'email'

            if @resource.update(password_params)
              DeviseMailer.password_changed(@resource).deliver_later

              render_update_success
            else
              render_update_error
            end
          else
            render_unprocessable_entity_error
          end
        end

        private

        def password_params
          params.permit(:password, :password_confirmation).merge(reset_password_token: nil)
        end

        # DeviseTokenAuth methods:

        def render_update_success
          render json: {
            success: true,
            data: resource_data,
            message: I18n.t('devise_token_auth.passwords.successfully_updated')
          }
        end

        def render_update_error
          render json: {
            success: false,
            errors: resource_errors
          }, status: :unprocessable_entity
        end

        def render_unprocessable_entity_error
          render json: {
            success: false
          }, status: :unprocessable_entity
        end

        def resource_data(opts = {})
          response_data = opts[:resource_json] || @resource.as_json
          response_data['type'] = @resource.class.name.parameterize
          response_data
        end
      end
    end
  end
end
