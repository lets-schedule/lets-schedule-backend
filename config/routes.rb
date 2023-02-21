Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :task, only: [:index, :show, :create, :destroy] do
    resources :event, only: [:index, :show, :create, :destroy]
    resources :constraint, only: [:index, :create, :destroy]
  end
end
