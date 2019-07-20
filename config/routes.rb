Rails.application.routes.draw do
  # For details on the DSL available within this file, see 
  # http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'

  resources :users, only: [:new, :create]
  
  get '/auth/google_oauth2/callback', to: 'google_users#create'
  resources :google_users, only: [:edit]

  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :landmarks, only: [:index]
end
