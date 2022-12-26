# frozen_string_literal: true

class SendAbandonedCartRemindersJob < ApplicationJob
  queue_as :mailers

  def perform
    AbandonedCarts::RemindersSender.new.call
  end
end
