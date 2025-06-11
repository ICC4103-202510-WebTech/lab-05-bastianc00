class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.persisted?
      can :read, :all
      can :create, [Chat, Message]
      can [:update, :destroy], Message, user_id: user.id
      can [:update, :destroy], Chat, sender_id: user.id
    end
  end
end