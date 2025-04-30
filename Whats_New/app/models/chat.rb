class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages
  
  
  validates :sender_id, :receiver_id, presence: true
  validate :sender_and_receiver_different
  
  private
  
  def sender_and_receiver_different
    errors.add(:receiver_id, "can't be the same as sender") if sender_id == receiver_id
  end
end