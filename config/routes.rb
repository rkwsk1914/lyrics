Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  delete 'requests/:id', to: 'requests#destroy'
  
  

  resources :users, only: [:show, :new, :create] do
    member do
      get :followings
      get :followers
      get :likes
      get :talkings
      get :origin
    end
  end
  
  resources :lyrics, only: [:show, :new, :create,] do
      member do
      get :apply
    end
  end
  
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :lyrics
  resources :talkrooms, only: [:show, :create]
  resources :messages, only: [:create]
  resources :comments, only: [:create]
  resources :requests#, only: [:create, :edit, :update, :destroy]
end
