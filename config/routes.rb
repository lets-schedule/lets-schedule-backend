Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  patch '/user', to: 'user#update'
  get '/user', to: 'user#index'
  get '/event', to: 'event#filter'
  patch '/task/:task_id/constraint', to: 'constraint#update'
  delete '/task/:task_id/constraint', to: 'constraint#destroy'
  resources :task, only: [:index, :show, :create, :destroy, :update] do
    resources :event, only: [:index, :show, :create, :destroy, :update]
    resources :constraint, only: [:index, :create]
  end
end
