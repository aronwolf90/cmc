Rails.application.routes.draw do
  devise_for :users

  namespace :administration do
    root to: 'dashboards#show'

    resource :dashboard, only: :show
    resource :board, only: %i[show update]
    resources :board_lists do
      resources :issues, only: %i[show new create edit update]
    end

    resources :users, only: %i[edit update]

    resources :projects

    resources :departments

    namespace :wiki do
      root to: 'pages#index'

      resources :pages
    end

    get '*path' => redirect('/administration')
  end

  namespace :api do
    namespace :v1 do
      resource :general_board, only: :show
      resources :board_lists, only: %i[index update destroy]
      patch :board_lists, to: 'board_lists#patch_update', as: :patch_update

      resources :issues, only: %i[show update] do
        resources :comments, only: :create
      end

      resources :users, only: :index
    end
  end

  root to: 'health#index'
end
