CodeAmbush::Application.routes.draw do
  get 'follow', to: 'follow#index', as: :follow
  resources :followings, only: %w(create destroy)

  devise_for :users

  root to: 'follow#index'

  resources :users
  resources :badges do
    get 'openbadge', on: :member 
  end
  get 'tags/:tag', to: 'badges#index', as: :tag
  resources :recognitions, only: %w(create destroy)

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
end
