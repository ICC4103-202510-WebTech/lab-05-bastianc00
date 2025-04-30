Rails.application.routes.draw do
  resources :users, only: [:index, :show, :new, :create]
  resources :chats, only: [:index, :show, :new, :create]
  resources :messages, only: [:index, :show, :new, :create]
  
  root 'users#index'
end
