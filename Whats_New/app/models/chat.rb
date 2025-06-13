class Chat < ApplicationRecord
  # Asociaciones
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :messages, dependent: :destroy

  scope :for_user, ->(user) {
    where("sender_id = :user_id OR receiver_id = :user_id", user_id: user.id)
  }

  # Validaciones
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validate :cannot_message_self

  def other_participant(current_user)
    current_user.id == sender_id ? receiver : sender
  end
  
  private

  def cannot_message_self
    errors.add(:receiver_id, "Cannot be the same as sender") if sender_id == receiver_id
  end
end