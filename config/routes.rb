Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/about', to: "static_pages#about"

  get '/signup', to: "users#new"

  get '/signin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  delete '/signout', to: "sessions#destroy"

  resources :users do # routes に /users/:id/following  /users/:id/followers　ができる
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
