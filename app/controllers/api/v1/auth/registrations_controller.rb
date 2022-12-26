# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        include LoginInformationSavable

        def create
          super do |user|
            if params[:user_type] == 'designer'
              designer = user.build_designer(display_name: params[:display_name])

              designer.save(validate: false)
            end

            if params[:user_type] == 'client'
              company = Company.new(country_code: country_code)
              company.save(validate: false)

              client = user.build_client(company: company)

              client.save(validate: false)
            end

            user.skip_confirmation! if resource_class.devise_modules.include?(:confirmable)
            save_login_information(user: user)
          end
        end

        private

        def country_code
          Geocoder.search(request.remote_ip).first&.country_code
        end

        protected

        def resource_data
          if @resource.object
            ActiveModelSerializers::SerializableResource.new(@resource.object).as_json[:data]
          else
            super
          end
        end

        def render_create_success
          cookies.permanent.encrypted[:signed_uid] = @resource.uid

          super
        end

        def sign_up_params
          params.permit(:email, :password)
        end
      end
    end
  end
end
