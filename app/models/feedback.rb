# frozen_string_literal: true

class Feedback < ApplicationRecord
  validates :name, :email, :subject, :message, presence: true
end
