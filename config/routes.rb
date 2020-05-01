Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'message', to: 'sentmessages#new'
  post 'message', to: 'sentmessages#create'
  

  resources :users, only: [:show, :new, :create] do #:index
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  #resources :lyrics, only: [:index, :show, :new, :create] do
  #  member do
  #    get :likers
  #  end
  #end
  
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :lyrics
  resources :sentmessages, only: [:index, :new, :create, :destroy]
  resources :receivemessages, only: [:index, :new, :create, :destroy]
end
