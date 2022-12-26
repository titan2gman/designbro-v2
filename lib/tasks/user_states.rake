# frozen_string_literal: true

namespace :user_states do
  task make_active: :environment do
    User.where('created_at < ?', 1.day.ago).update_all(state: :active)
  end
end
