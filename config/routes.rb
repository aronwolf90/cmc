# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  root to: redirect("/users/sign_in")

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(username),
      ::Digest::SHA256.hexdigest("admin")
    ) & ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(password),
      ::Digest::SHA256.hexdigest(Settings.admin_password)
    )
  end
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: { sessions: "sessions" }

  resources :registrations, only: %i[new create]
  resource :terms, only: :show
  get "google_calenders/create_callback", to: "google_calenders#create_callback"
  post "google_calenders/notification", to: "google_calenders#notification"

  namespace :admin_area do
    root to: "organizations#index"

    resources :organizations, only: :index
  end

  namespace :administration do
    root to: "dashboards#show"

    resource :dashboard, only: :show
    resources :records, except: :show

    resources :users, except: %i[edit create destroy] do
      scope module: :users do
        resources :records, only: :index
      end
    end

    resource :archive, only: [], controller: :archive do
      scope module: :archive do
        resources :folders, except: %i[index show]
      end
    end

    resource :wiki, only: [], controller: :wiki do
      scope module: :wiki do
        resources :categories, except: %i[index show]
        resources :pages, only: %i[new create]
      end
    end

    resources :projects, only: %i[] do
      scope module: :projects do
        resources :records, only: :index
      end
    end

    namespace :admin do
      resources :payments, only: :index
    end

    get "/*path", to: "app#show", format: false
  end

  namespace :api do
    namespace :v1 do
      resources :user_tokens, only: :create

      resource :context, only: %i[show update]

      resources :board_lists, only: %i[index show create update destroy] do
        scope module: :board_lists do
          collection do
            resource :sort, only: :update
          end
          resources :issues, only: :index
        end
      end

      resources :issues, only: %i[index show create update destroy] do
        scope module: :issues do
          resource :close, only: :create
          resources :comments, only: :index
        end
      end
      resources :comments, only: :create

      resources :users, only: %i[index show create update destroy] do
        scope module: :users do
          resource :current_record, only: :show
          resource :configuration, only: :update
        end
      end

      resources :records, only: %i[create update]

      resources :projects, only: %i[index show create update destroy] do
        scope module: :projects do
          resources :project_comments, only: :index
          resources :reminders, only: :index
        end
      end
      resources :project_comments, only: %i[create]

      resources :wiki_categories, only: :index
      resources :wiki_pages, only: %i[show update destroy]
      resources :folders, only: %i[index show]
      resources :user_issues, only: %i[index show]
      resources :events, only: %i[index create update destroy]
      resources :attendance_days, only: :index
      resources :attendance_events, only: %i[index create update destroy]
      resources :contacts, only: %i[index show create update destroy]
      resources :contact_avatars, only: %i[show create]
      resources :document_files, only: %i[show create update]
      resources :documents, only: %i[index show create update destroy]
      resources :stripe_checkout_sessions, only: :create
      resources :invoices, only: :index
      resource :subscription, only: :show
      resources :notifications, only: :index
      resource :notifications_readed, only: :create
      resource :test_organizations, only: %i[create destroy]
      resources :project_statuses, only: %i[index create update show destroy]
      resources :project_board_lists, only: %i[show create update destroy] do
        scope module: :project_board_lists do
          resources :projects, only: :index
        end
      end
      resource :health_check, only: :show
    end
  end
end
