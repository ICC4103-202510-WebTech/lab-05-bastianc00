class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  
  validates :body, :chat_id, :user_id, presence: true
end