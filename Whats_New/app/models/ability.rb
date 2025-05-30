# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    # Lectura general
    can :read, :all
    
    # Mensajes
    can :create, Message
    can [:update, :destroy], Message, user_id: user.id
    
    # Chats
    can :create, Chat
    can :manage, Chat, sender_id: user.id
    can :manage, Chat, receiver_id: user.id
    
    # Usuarios
    can :read, User
    can [:update], User, id: user.id
    # Solo permitir borrar otros usuarios, no a sí mismo
    can :destroy, User do |target_user|
      target_user != user
    end
  end
end
