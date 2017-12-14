Rails.application.routes.draw do
  devise_for :users

  namespace :administration do
    root to: 'dashboards#show'

    resource :dashboard, only: :show
    resource :board, only: :show
    resources :board_lists
    resources :issues, only: %i[new create edit update]

    resources :users, only: %i[edit update]

    resources :projects

    resources :departments

    namespace :wiki do
      root to: 'pages#index'

      resources :pages
    end

    get '*path' => redirect('/administration')
  end

  root to: 'health#index'
end
