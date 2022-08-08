Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  root "articles#index"
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'healthcheck', to: 'healthchecks#show'
  #delete "users/:id", to: "users#destroy"
  resources :users
  resources :sessions
  resources :articles do
    resources :comments
  end
  resources :galleries do
    resources :pictures do
      resources :comments
    end
  end
end
