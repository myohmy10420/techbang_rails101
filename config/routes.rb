Rails.application.routes.draw do
  devise_for :users
  root to: "groups#index"

  resources :groups do
    member do
      post :join
      post :quit
    end

    resources :posts
  end

  namespace :account do
    resources :groups
  end
end
