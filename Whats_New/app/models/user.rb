class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 
  has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id'
  has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id'
  has_many :messages

  
  def chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id)
  end

  
  scope :all_except, ->(user) { where.not(id: user.id) }
end