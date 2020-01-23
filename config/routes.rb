Rails.application.routes.draw do
  get 'answers/new'
  get 'lessons/create'
  get 'lessons/show'
  namespace :admin do
    get 'home', to: 'pages#home'
    resources :users
    resources :categories do
      resources :words
      member do
        get :words
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/about', to: "static_pages#about"

  get '/signup', to: "users#new"
  get '/dashboard', to: "users#dashboard"

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
  resources :categories
  resources :lessons do
    resources :answers
  end
end
