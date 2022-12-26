# frozen_string_literal: true

module LoginInformationSavable
  extend ActiveSupport::Concern

  def save_login_information(user:)
    Login.create(user: user, ip: request.remote_ip, origin: cookies[:referrer], origin_2: cookies[:designbro_referrer])
  end
end
