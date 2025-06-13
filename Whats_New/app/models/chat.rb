class Chat < ApplicationRecord
  # Asociaciones
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :messages, dependent: :destroy

  # Validaciones
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validate :cannot_message_self

  private

  def cannot_message_self
    errors.add(:receiver_id, "Cannot be the same as sender") if sender_id == receiver_id
  end
end