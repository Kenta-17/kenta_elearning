Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/signup', to: "users#new"

  get '/signin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  delete '/signout', to: "sessions#destroy"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
