Rails.application.routes.draw do
  devise_for :users

  namespace :administration do
    root to: 'dashboard#index'

    resource :dashboard, only: :index

    namespace :user_settings do
      resource :users, only: %i[show edit]
    end
  end

  root to: 'health#index'
end
