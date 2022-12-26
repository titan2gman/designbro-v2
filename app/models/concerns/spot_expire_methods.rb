# frozen_string_literal: true

module SpotExpireMethods
  extend ActiveSupport::Concern

  include TimeMethods

  def reservation_expired?
    time_from(reserved_state_started_at) / 1.hour >= reservation_expire_duration / 1.hour
  end

  def send_12_hours_of_reservation_left_warning?
    time_from(reserved_state_started_at) / 1.hour == reservation_left(13.hours) / 1.hour
  end

  def reservation_expire_duration
    reservation_expire_days.days
  end

  private

  def reservation_left(time)
    reservation_expire_duration - time
  end
end
