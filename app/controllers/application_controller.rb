# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def after_sign_in_path_for(resource)
    return request.referrer unless resource.is_a?(AdminUser)

    if current_admin_user.view_only
      [ActiveAdmin.application.default_namespace, :winners]
    else
      [ActiveAdmin.application.default_namespace, :dashboard]
    end
  end
end
