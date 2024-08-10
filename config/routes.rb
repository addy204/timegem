# config/routes.rb
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    registrations: "users/registrations"
  }

  devise_scope :user do
    get "users/sign_out", to: "devise/sessions#destroy"
  end

  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]

  resource :cart, only: [:show] do
    post "add/:product_id", to: "carts#add", as: "add_to"
    patch "update/:product_id", to: "carts#update", as: "update"
    delete "remove/:product_id", to: "carts#remove", as: "remove_from"
    patch "decrease/:product_id", to: "carts#decrease", as: "decrease_quantity"
  end

  resources :orders, only: %i[index new create show edit update destroy]

  # Route for static pages handled by PagesController
  get "/pages/:title", to: "pages#show", as: "page"

  # Root route for the product page
  root "products#index"
end
