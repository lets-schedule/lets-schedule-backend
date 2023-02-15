Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :user, only: [:index, :show, :create, :update, :destroy]
  resources :task, only: [:index, :show, :create, :update, :destroy]
  resources :event, only: [:index, :show, :create, :update, :destroy]
  resources :constraint, only: [:index, :show, :create, :update, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
