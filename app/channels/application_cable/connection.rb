# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      uid = cookies.encrypted['signed_uid']

      token  = cookies[DeviseTokenAuth.headers_names[:'access-token']]
      client = cookies[DeviseTokenAuth.headers_names[:client]]

      user = User.find_by(uid: uid)

      reject_unauthorized_connection unless user&.valid_token?(token, client)

      user
    end
  end
end
