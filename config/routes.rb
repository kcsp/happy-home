Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'owner', to: 'pages#owner'
  get 'signup', to: 'users#new'
  resources 'users', except: [:new]
  resources 'houses'
  resources 'transactions', except: [:new,:create,:destroy]
  post 'book', to: 'transactions#create'
  #post 'houses/book', to:'houses#book'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
