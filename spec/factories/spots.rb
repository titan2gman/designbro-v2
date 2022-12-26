# frozen_string_literal: true

FactoryBot.define do
  factory :spot do
    designer
    project
    reserved_state_started_at { Time.zone.now }

    state { Spot.aasm.states.map(&:name).sample }

    Spot.aasm.states.map(&:name).each do |state|
      factory(:"#{state}_spot") do
        state { state }
      end
    end
  end
end
