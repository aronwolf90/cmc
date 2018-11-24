# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect("/users/sign_in")

  devise_for :users, controllers: { sessions: "sessions" }

  resources :registrations, only: %i[new create]
  resource :terms, only: :show

  namespace :administration do
    root to: "dashboards#show"

    resource :dashboard, only: :show
    resources :records, except: :show
    resource :board, only: :show
    resources :board_lists, only: %i[new create edit update destroy] do
      resources :issues, only: %i[new create]
    end
    resources :issues, only: :show
    resource :calender, only: :show

    resource :organization, only: %i[edit update]

    resources :users, except: %i[show destroy] do
      scope module: :users do
        resource :configuration, only: %i[edit update destroy]
        resources :records, only: :index
      end
    end

    resources :projects, except: :show do
      scope module: :projects do
        resource :dashboard, only: :show
        resources :records, only: :index
      end
    end

    namespace :wiki do
      root to: "contents#show"

      resources :categories, except: %i[index show]
      resource :content, only: :show
      resources :pages, only: %i[show new create]
    end

    namespace :archive do
      root to: "contents#show"

      resource :content, only: :show
      resources :folders, except: %i[index show]
      resources :documents, except: :index
    end

    get "*path" => redirect("/administration")
  end

  namespace :api do
    namespace :v1 do
      resources :user_tokens, only: :create

      resource :context, only: :show

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
      resources :wiki_categories, only: :index
      resources :wiki_pages, only: %i[show update destroy]
      resources :folders, only: :index
      resources :user_issues, only: %i[index show]
      resources :events, only: %i[index create update destroy]
    end
  end
end
