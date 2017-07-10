Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/search", to: "static_pages#search"
  get "/admin", to: "static_pages#admin"
  get "/load_statistics", to: "static_pages#load_statistics"
  devise_for :users
  devise_scope :user do
    get "/sign_in", to: "devise/sessions#new"
    delete "/sign_out", to: "devise/sessions#destroy"
  end
  resources :users, except: :new do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts
  resources :comments
  resources :likes, only: [:create, :destroy]
  resources :tags, only: :show
end

