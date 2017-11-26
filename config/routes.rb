Rails.application.routes.draw do
  devise_for :users

  namespace :administration do
    root to: 'dashboard#index'

    resource :dashboard, only: :index

    namespace :user_settings do
      resources :users, only: %i[edit update]
    end
  end

  root to: 'health#index'
end
