Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/users/edit', to: 'devise/registrations#edit'
  get '/users/index', to: 'users#index'
  resources :users, only: [:show, :edit, :update]
  resources :microposts, only: [:create, :destroy]
end
