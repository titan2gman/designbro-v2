# frozen_string_literal: true

class StartNotificationRequest < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
