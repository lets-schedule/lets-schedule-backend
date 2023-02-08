Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :user, only: [:index, :show, :create, :update, :delete]
  resources :task, only: [:index, :show, :create, :update, :delete] do
    resources :event, only: [:index, :show, :create, :update, :delete]
    resources :conflict, only: [:index, :show, :create, :update, :delete]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
