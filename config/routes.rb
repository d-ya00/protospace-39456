Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'
  resources :prototypes, only: [:index, :new, :create, :show, :edit]
  resources :users, only: [:show] 
  resources :comments, only: [:create]
end