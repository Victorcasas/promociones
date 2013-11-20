LearnRails::Application.routes.draw do
  resources :contacts, only: [:new, :create]
  resources :visitors, only: [:new, :create]
  resources :calculos, only: [:new, :create]
  root to: 'pages#index'
end
