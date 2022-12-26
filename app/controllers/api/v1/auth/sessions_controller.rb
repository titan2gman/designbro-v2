# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < DeviseTokenAuth::SessionsController
        include LoginInformationSavable

        def create
          super do |user|
            save_login_information(user: user)
          end
        end

        def destroy
          super { cookies.delete :signed_uid }
        end
      end
    end
  end
end
