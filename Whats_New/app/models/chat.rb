class Chat < ApplicationRecord
  # Asociaciones
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :messages, dependent: :destroy

  # Validaciones
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validate :sender_and_receiver_different

  private

  def sender_and_receiver_different
    if sender_id == receiver_id
      errors.add(:receiver_id, "no puede ser el mismo que el remitente")
    end
  end
end 