Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post 'add/:product_id', to: 'carts#add', as: 'add_to'
    patch 'update/:product_id', to: 'carts#update', as: 'update'
    delete 'remove/:product_id', to: 'carts#remove', as: 'remove_from'
  end

  resources :orders, only: [:new, :create, :show]

  get '/pages/:title', to: 'pages#show', as: 'page'

  root "products#index"
end
