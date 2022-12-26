# frozen_string_literal: true

RSpec.describe PayoutListener do
  let(:payout) { create(:payout) }

  describe '#payout_request' do
    it 'delivers payout_request to PayoutMailer' do
      expect(PayoutMailer).to receive(:payout_request).with(payout: payout).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.payout_request(payout)
    end
  end
end
