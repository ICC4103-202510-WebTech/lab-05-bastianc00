# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :all
    can :create, Message
    can [:update, :destroy], Message, user_id: user.id
    can :manage, Chat, sender_id: user.id
    can :manage, Chat, receiver_id: user.id
    can :read, User
    can [:update], User, id: user.id
  end
end
