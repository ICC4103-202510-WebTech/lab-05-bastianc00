Rails.application.routes.draw do
  resources :users, only: [:index, :show, :new, :create, :edit, :update]
  resources :chats, only: [:index, :show, :new, :create, :edit, :update]
  resources :messages, only: [:index, :show, :new, :create, :edit, :update]
  
  root 'users#index'
end