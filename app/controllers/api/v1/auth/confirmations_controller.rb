# frozen_string_literal: true

module Api
  module V1
    module Auth
      class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
        def show
          @resource = resource_class.confirm_by_token(params[:confirmation_token])

          raise ActionController::RoutingError, 'Not Found' unless @resource&.id

          # create client id
          client_id  = SecureRandom.urlsafe_base64(nil, false)
          token      = SecureRandom.urlsafe_base64(nil, false)
          token_hash = BCrypt::Password.create(token)
          expiry     = (Time.now + DeviseTokenAuth.token_lifespan).to_i

          @resource.tokens[client_id] = {
            token: token_hash,
            expiry: expiry
          }

          @resource.save!

          yield @resource if block_given?

          cookies.permanent.encrypted['signed_uid'] = @resource.uid

          cookies[DeviseTokenAuth.headers_names[:'access-token']] = token
          cookies[DeviseTokenAuth.headers_names[:'token-type']] = 'Bearer'
          cookies[DeviseTokenAuth.headers_names[:client]] = client_id
          cookies[DeviseTokenAuth.headers_names[:uid]] = @resource.uid

          redirect_to params[:redirect_url]
        end

        def create
          self.resource = resource_class.send_confirmation_instructions(confirmation_resend_params)
          yield resource if block_given?

          render json: { success: true }
        end

        private

        def confirmation_resend_params
          params.require(:confirmation).permit(:email)
        end
      end
    end
  end
end
