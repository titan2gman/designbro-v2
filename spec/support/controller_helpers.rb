# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :controller) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(@controller).to receive(:current_ability).and_return(@ability)
    @ability.can :manage, :all
  end
end
