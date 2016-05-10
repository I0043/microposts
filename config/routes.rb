Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'followings'
      get 'followers'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts do
    member do
      post 'like'
      delete 'unlike'
    end
  end
  resources :relationships, only: [:create, :destroy]
#resources :followings do
# member do
#  get 'users'
#end
#resources :followers do
#member do
# get 'user'
#end
end
