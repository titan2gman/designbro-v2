# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendAbandonedCartRemindersJob do
  describe '#perform' do
    it 'calls AbandonedCarts::RemindersSender' do
      expect_any_instance_of(AbandonedCarts::RemindersSender).to receive(:call)
      subject.perform
    end
  end
end
