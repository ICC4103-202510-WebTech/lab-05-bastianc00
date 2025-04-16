Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  resources :chats, only: [:index, :show]
  resources :messages, only: [:index, :show]
  
  root 'users#index'
end
