Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }
  resources :messages
  resources :chats
  resources :users, only: [:index, :show]
  root 'messages#index'
end