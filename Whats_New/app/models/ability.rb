class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (no logueado)

    if user.persisted?
      # Permisos para Chats
      can :read, Chat do |chat|
        chat.sender == user || chat.receiver == user
      end
      can :create, Chat

      # Permisos para Messages
      can :create, Message
      can [:update, :destroy], Message, user_id: user.id

      # Permisos para Users
      can :read, User
      can :update, User, id: user.id
    end
  end
end