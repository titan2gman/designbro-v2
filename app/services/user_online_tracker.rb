# frozen_string_literal: true

class UserOnlineTracker
  def call(user, expiry: 5.minutes)
    key = "last_seen_#{user.id}"
    return if Rails.cache.exist?(key)

    user.update(last_seen_at: Time.now)
    Rails.cache.write(key, true, expires_in: expiry)
  end
end
