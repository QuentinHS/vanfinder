Rails.application.routes.draw do
  resources :listings

  devise_for :users
  root to: 'listings#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show], as: "profile" 

  get "/search", to: "listings#search"


end
