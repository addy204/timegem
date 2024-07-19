Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post 'add/:product_id', to: 'carts#add', as: 'add_to'
    patch 'update/:product_id', to: 'carts#update', as: 'update'
    delete 'remove/:product_id', to: 'carts#remove', as: 'remove_from'
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "products#index"
end
