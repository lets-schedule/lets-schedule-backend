Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  patch '/user', to: 'user#update'
  get '/user', to: 'user#index'
  get '/event', to: 'event#filter'
  resources :task, only: [:index, :show, :create, :destroy, :update] do
    resources :event, only: [:index, :show, :create, :destroy, :update]
    resources :constraint, only: [:index, :create, :update, :destroy]
  end
end
