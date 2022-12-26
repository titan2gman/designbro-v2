# frozen_string_literal: true

class ConvertGooglePlusToEmailUsers < ActiveRecord::Migration[5.1]
  def change
    User.where(provider: :google_oauth2).each do |user|
      UserMailer.google_plus_functionality_removed(user: user).deliver_later
    end

    User.where(provider: :google_oauth2).update_all(
      "provider = 'email', uid = email"
    )
  end
end
