# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :administration do
    root to: "dashboards#show"

    resource :dashboard, only: :show
    resources :records, except: :show
    resource :board, only: :show
    resources :board_lists, only: %i[new create] do
      resources :issues, only: %i[show new create]
    end

    resources :users, only: %i[edit update]

    resources :projects, except: %i[show destroy] do
      scope module: :projects do
        resource :dashboard, only: :show
      end
    end

    resources :departments, only: :index

    namespace :wiki do
      root to: "pages#index"

      resources :pages, only: :index
    end

    get "*path" => redirect("/administration")
  end

  namespace :api do
    namespace :v1 do
      resources :user_tokens, only: :create

      resource :context, only: :show

      resource :general_board, only: %i[show update]
      resources :board_lists, only: %i[index show update destroy] do
        scope module: :board_lists do
          collection do
            resource :sort, only: :update
          end
        end
      end

      resources :issues, only: %i[index show update destroy]
      resources :comments, only: :create

      resources :users, only: %i[index update] do
        resource :current_record, only: :show
      end
      resources :records, only: %i[create update]
      resources :projects, only: :index
    end
  end

  root to: "health#index"
end
