# frozen_string_literal: true

class CheckSpotsJob < ApplicationJob
  def perform
    SpotsExpire.new.call
  end
end
