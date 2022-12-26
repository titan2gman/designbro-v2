# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserOnlineTracker do
  before do
    Rails.cache.clear
  end

  after do
    Rails.cache.clear
  end

  describe '#call' do
    context 'without cached value' do
      it 'updates users last_seen_at attribute' do
        user = double('user', id: 'id', update: true)
        tracker = UserOnlineTracker.new

        tracker.call(user)

        expect(user).to have_received(:update)
      end

      it 'populates cache' do
        user = double('user', id: 'id', update: true)
        allow(Rails.cache).to receive(:write)
        tracker = UserOnlineTracker.new

        tracker.call(user)

        expect(Rails.cache).to have_received(:write)
      end
    end

    context 'with cached value' do
      it 'dont trigger db update' do
        user = double('user', id: 'id', update: true)
        allow(Rails.cache).to receive(:exist?).and_return(true)
        tracker = UserOnlineTracker.new

        tracker.call(user)

        expect(user).not_to have_received(:update)
      end

      it 'dont rewrite cache' do
        user = double('user', id: 'id', update: true)
        allow(Rails.cache).to receive(:exist?).and_return(true)
        allow(Rails.cache).to receive(:write).and_return(true)
        tracker = UserOnlineTracker.new

        tracker.call(user)

        expect(Rails.cache).not_to have_received(:write)
      end
    end
  end
end
