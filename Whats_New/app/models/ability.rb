class Ability
  include CanCan::Ability

  def initialize(user)
    # Reglas para invitados (usuarios no logueados)
    return unless user.present?

    # Reglas básicas para todos los usuarios autenticados
    can :read, Message
    can :create, Message
    can [:update, :destroy], Message, user_id: user.id

    # Reglas para Chats
    can :create, Chat
    can :read, Chat do |chat|
      chat.sender_id == user.id || chat.receiver_id == user.id
    end
    can [:update, :destroy], Chat, sender_id: user.id

    # Reglas para Users
    can :read, User, id: user.id
    can :update, User, id: user.id

    # Permisos para admin (con verificación segura)
    if user.respond_to?(:admin?) && user.admin?
      can :manage, :all
    end
  end
end