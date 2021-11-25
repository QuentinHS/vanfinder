Rails.application.routes.draw do
  # create resources for listings
  resources :listings
  # create resources for users
  devise_for :users
  # set root to listings index
  root to: 'listings#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # create profile path for users
  resources :users, as: "profile" 
  # Associate messages routes with users
  resources :users do
    :profile
    resources :messages, only: [:new, :create] #-> domain.com/users/:user_id/messages/new
  end
  # create routes for messages 
   resources :messages, only: [:index, :show, :destroy] #-> domain.com/messages/:id
  # create search route
  get "/search", to: "listings#search"


end
