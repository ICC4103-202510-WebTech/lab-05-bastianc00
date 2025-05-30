Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :chats, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :messages, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  root 'users#index'
end
