Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'pricing', to: 'pages#pricing'
  get 'contact', to: 'pages#contact'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new] do
    member do
      patch :toggle_admin
    end
  end
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories do
    member do
      patch :toggle_featured
    end
  end
  resources :articleCategory, only: [:destory]
end
