Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:create, :update, :destroy]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      post '/search', to: 'users#search'
    end
  end 
  resources :events, only: [:create, :update, :destroy]
  resources :memberships, only: [:create, :update, :destroy]
  resources :ensembles, only: [:create, :update, :destroy]
  resources :user_events, only: [:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
