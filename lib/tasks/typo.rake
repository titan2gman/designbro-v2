# frozen_string_literal: true

namespace :typo do
  task earning: :environment do
    Earning.where(state: :payed).update_all(state: :paid)
  end

  task payout: :environment do
    Payout.where(payout_state: :payed).update_all(payout_state: :paid)
  end
end
