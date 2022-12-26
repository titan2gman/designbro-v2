# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    uid = cookies.encrypted['signed_uid']

    token  = cookies[DeviseTokenAuth.headers_names[:'access-token']]
    client = cookies[DeviseTokenAuth.headers_names[:client]]

    user = User.find_by(uid: uid)

    @user = user.object if user&.valid_token?(token, client)
  end
end
