Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'posts#index', as: 'home'
  get '/new', to: 'posts#new', as: 'new_post'
  post '/', to: 'posts#create', as: 'posts'
  get '/:id', to: 'posts#show', as: 'post'
  delete '/:id', to: 'posts#destroy'

  resources :post do
    resources :comments, only: [:create, :destroy]
  end

end
