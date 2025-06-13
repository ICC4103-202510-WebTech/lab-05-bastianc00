class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  
  validates :body, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :chat_id, :user_id, presence: true
end