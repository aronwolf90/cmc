Rails.application.routes.draw do
  devise_for :users

  namespace :administration do
    root to: 'dashboards#show'

    resource :dashboard, only: :show
    resource :board, only: :show
    resource :issues, only: %i[new update]

    resources :users, only: %i[edit update]

    resources :projects

    resources :departments

    namespace :wiki do
      root to: 'pages#index'

      resources :pages
    end
  end

  root to: 'health#index'
end
