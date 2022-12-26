# frozen_string_literal: true

class AdminUserAbility
  include CanCan::Ability

  def initialize(user)
    view_only_abilities

    return if user.view_only?

    can :manage, :all
  end

  def view_only_abilities
    can :read, Project
  end
end
