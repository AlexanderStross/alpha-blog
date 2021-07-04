Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new] do
    member do
        patch :toggle_admin
    end
  end
  resources sessions, only: [:new, :create, :destroy], path_names: { new: "login", create: "login", destroy: "logout" }
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
