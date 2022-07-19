Rails.application.routes.draw do
  
  devise_for :users
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/users/edit', to: 'devise/registrations#edit'
  get '/users/index', to: 'users#index'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy, :edit, :update]
  resources :microposts do
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
