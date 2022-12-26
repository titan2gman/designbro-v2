# frozen_string_literal: true

namespace :designers do
  task one_to_one: :environment do
    Designer.joins(:winner_spots).uniq.each do |d|
      d.update(one_to_one_allowed: true)
    end
  end
end
