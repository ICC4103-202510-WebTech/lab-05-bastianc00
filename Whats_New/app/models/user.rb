class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :sent_messages, class_name: 'Message', foreign_key: 'user_id'
  has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id'
  has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id'
  
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  def chats
    Chat.where("sender_id = :id OR receiver_id = :id", id: id)
  end

  def admin?
    admin || false 
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end