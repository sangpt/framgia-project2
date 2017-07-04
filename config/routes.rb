Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  devise_for :users
  devise_scope :user do
    get "/sign_in", to: "devise/sessions#new"
    delete "/sign_out", to: "devise/sessions#destroy"
  end
end

