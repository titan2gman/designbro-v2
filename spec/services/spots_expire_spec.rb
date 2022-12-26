# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpotsExpire do
  describe '#call' do
    describe 'with expired spot' do
      it 'change spot state to expired' do
        project = create(:project)
        spot = create(:reserved_spot,
                      reserved_state_started_at: Time.zone.now,
                      project: project)
        expired_spot = create(:reserved_spot,
                              reserved_state_started_at: 2.days.ago,
                              project: project)
        spot_in_queue = create(:in_queue_spot,
                               project: project)

        SpotsExpire.new.call
        expired_spot.reload
        spot.reload
        spot_in_queue.reload

        expect(expired_spot.state).to eq(Spot::STATE_EXPIRED.to_s)
        expect(spot.state)        .to eq(Spot::STATE_RESERVED.to_s)
        expect(spot_in_queue.state) .to eq(Spot::STATE_RESERVED.to_s)
      end
    end

    describe 'with spot that will expire after 12 hours' do
      it 'send warning to designer' do
        project = create(:logo_project)
        create(:reserved_spot,
               reserved_state_started_at: 12.hours.ago,
               project: project)
        allow(DesignerMailer).to receive(:reservation_12_hours_left).and_return(double('DesignerMailer', deliver_later: true))

        SpotsExpire.new.call

        expect(DesignerMailer).to have_received(:reservation_12_hours_left)
      end
    end
  end
end
