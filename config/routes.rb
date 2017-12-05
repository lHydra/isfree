Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'

  resources :conversations, only: [:index, :show] do
    resources :messages, only: [:create]
  end

  resources :creases do
    resources :conversations, only: [:new, :create]
    resources :purchases, only: [:create, :destroy]
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
