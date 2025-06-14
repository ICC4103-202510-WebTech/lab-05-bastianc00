# Elimina todos los datos existentes antes de sembrar nuevos datos
Message.delete_all
Chat.delete_all
User.delete_all

10.times do |i|
  User.create!(
    email: "user#{i+1}@example.com",
    first_name: "FirstName#{i+1}",
    last_name: "LastName#{i+1}",
    password: "password123",
    password_confirmation: "password123"
  )
end

User.create!(
  email: 'admin@example.com',
  first_name: 'Admin',
  last_name: 'User',
  password: 'password123',
  password_confirmation: 'password123',
  admin: true
)

10.times do |i|
  sender_id = User.offset(i % User.count).first.id
  receiver_id = User.offset((i+1) % User.count).first.id
  
  Chat.create!(
    sender_id: sender_id,
    receiver_id: receiver_id
  )
end


10.times do |i|
  Message.create!(
    chat_id: Chat.offset(i % Chat.count).first.id,
    user_id: User.offset(i % User.count).first.id,
    body: "This is message number #{i+1}"
  )
end
