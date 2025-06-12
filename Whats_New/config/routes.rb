Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :new, :create, :edit, :update]
  resources :chats, only: [:index, :show, :new, :create, :edit, :update]
  resources :messages, only: [:index, :show, :new, :create, :edit, :update]
  
  root 'users#index'
end