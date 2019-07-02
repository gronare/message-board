Rails.application.routes.draw do

  resources :posts, only: [:index, :create, :update, :destroy]
  post 'register', to: 'users#create'
  post 'authenticate', to: 'authentication#authenticate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
