Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users, only: :index
  end

  get '/', to: 'posts#index', as: 'home'
  get '/new', to: 'posts#new', as: 'new_post'
  # post '/', to: 'posts#create', as: 'posts'
  # get '/:id', to: 'posts#show', as: 'post'
  # delete '/:id', to: 'posts#destroy'

  resources :users, only: [:new, :create, :edit, :update]

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :sessions, only: [:new, :create] do
    get :destroy, on: :collection
  end

end
