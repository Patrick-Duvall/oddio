Rails.application.routes.draw do

  root to: 'welcome#index'

  ### Registration & Login
  get '/register', to: 'app_auths#new'
  resources :app_auths, only: [:create]

  resources :users, only: [:new, :create, :show]

  get '/auth/google_oauth2/callback', to: 'google_auths#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  ### Public
  # Landmarks
  resources :landmarks, only: [:index, :show]

  namespace :api do
    namespace :v1 do
      resources :landmarks, only: [:index, :show]
    end
  end

  # Recordings
  resources :recordings, only: [:index]

  # Tours
  resources :tours, only: [:index, :show, :create]
  get '/tours/:tour_id/landmarks/:id', to: 'tour/landmarks#show', as: 'tour_landmark'

  ### User
  namespace :user do
    get '/dashboard', to: 'dashboard#index'
    delete '/dashboard/:id', to: 'recordings#destroy', as: :delete_recording
    get '/votes', to: 'votes#create'
    resources :landmarks, only: [:show] do
      resources :recordings, only: [:new, :create]
    end
  end

  # Tour list
  get '/tour_list', to: 'tour_list#show'
  delete '/tour_list', to: 'tour_list#destroy', as: :empty_tour_list
  namespace :tour_list do
    resources :landmarks, only: [:show, :create, :destroy] do
      resources :recordings, only: [:index, :new, :create, :destroy]
      post '/recordings/:id', to: 'recordings#update', as: :pick_recording
    end
  end

  ### Admin

  namespace :admin do
    get '/users/:user_id', to: 'users#show'
    delete '/destroy/:id', to: 'recordings#destroy', as: :delete_recording
  end
end
