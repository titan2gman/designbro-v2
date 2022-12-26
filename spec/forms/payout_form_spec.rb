# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayoutForm do
  describe '#save' do
    context 'with valid attributes' do
      it 'saves payout' do
        designer = create(:designer)
        create(:payout_min_amount, amount: 25_000)
        create(:earning, designer: designer, amount: 25_000)

        payout = Payout.new(
          designer: designer,
          country: Faker::Address.country,
          payout_method: 'bank_transfer',
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          address1: Faker::Address.street_address,
          city: Faker::Address.city,
          phone: Faker::PhoneNumber.phone_number
        )
        form = PayoutForm.new(object: payout)

        expect(payout).to receive(:send_payout_request_email)

        expect { form.save }.to change { designer.payouts.count }.by(1)
      end
    end

    context 'with not enough earnings' do
      it 'is not save payout' do
        designer = create(:designer)
        create(:payout_min_amount, amount: 25_000)
        create(:earning, designer: designer, amount: 24_900)

        payout = Payout.new(
          designer: designer,
          country: Faker::Address.country,
          payout_method: 'bank_transfer',
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          address1: Faker::Address.street_address,
          city: Faker::Address.city,
          phone: Faker::PhoneNumber.phone_number
        )
        form = PayoutForm.new(object: payout)

        expect(payout).not_to receive(:send_payout_request_email)

        expect { form.save }.to change { designer.payouts.count }.by(0)
      end
    end
  end
end
