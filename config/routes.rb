Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
    #match '/login', to: 'sessions#create', via: :post
    #resources :sessions, only: [:create]
      match '/login', to: 'sessions#create', via: :post
      resources :sessions, only: [:create]
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :posts, only: [:index, :create, :show, :update, :destroy]
    end
  end
end