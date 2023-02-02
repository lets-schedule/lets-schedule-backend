Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :user, only: [:index, :create, :update, :delete]
  resources :task, only: [:index, :create, :update, :delete]
  resources :event, only: [:index, :create, :update, :delete]
  resources :conflict, only: [:index, :create, :update, :delete]
  # Defines the root path route ("/")
  # root "articles#index"
end
