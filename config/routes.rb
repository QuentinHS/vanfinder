Rails.application.routes.draw do
  resources :listings

  devise_for :users
  root to: 'listings#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show], as: "profile" 

  resources :users do
   get :profile
  resources :messages, only: [:new, :create] #-> domain.com/users/:user_id/messages/new
   end
   
   resources :messages, only: [:index, :show, :destroy] #-> domain.com/messages/:id

  get "/search", to: "listings#search"


end
