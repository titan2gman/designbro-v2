# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  unless Rails.env.test? || Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV.fetch('SIDEKIQ_USERNAME') &&
        password == ENV.fetch('SIDEKIQ_PASSWORD')
    end
  end

  mount Sidekiq::Web => '/admin/sidekiq'

  ActiveAdmin.routes(self)

  namespace :api, except: [:new, :edit], defaults: { format: 'json' } do
    namespace :v1 do
      put '/auth/password/reset', to: 'auth/passwords#reset'
      get '/auth/password/validate', to: 'auth/passwords#validate'

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        confirmations: 'api/v1/auth/confirmations',
        passwords: 'api/v1/auth/devise_passwords',
        sessions: 'api/v1/auth/sessions'
      }

      resources :portfolios, only: [:index, :create], controller: :portfolio_works do
        patch :skip, on: :collection
      end

      resources :uploaded_files, only: [:create]

      namespace :designers do
        resources :projects, only: [:index] do
          get :search, on: :collection
        end
      end

      namespace :clients do
        resources :spots, only: [] do
          get :finalists, on: :collection
        end
      end

      resources :portfolio_images, only: [:index]

      resources :designers, only: [:update] do
        patch :experience, on: :member
        patch :portfolio_settings, on: :member
      end

      get :designer_stats, controller: :designer_stats, action: :show

      resources :clients, only: [:update]

      resources :projects, only: [:index, :show, :update, :destroy] do
        resources :featured_images, only: [:create, :destroy]
        resources :project_source_files, only: [:index, :create, :destroy]
        resources :project_existing_designs, only: [:index]

        resources :designs, only: [:index, :show, :update, :create] do
          resources :messages, controller: 'direct_conversation_messages', only: [:index, :create]
          resources :versions, controller: 'designs/versions', only: [:index]
          patch :restore, on: :member
          patch :make_finalist, on: :member
          patch :eliminate, on: :member
          patch :block, on: :member
        end

        get :search, on: :collection
        post :manual_request, on: :collection
        post :upsell_spots, on: :member
        post :upsell_days, on: :member
      end

      resources :spots, only: [:create]

      post 'projects/:project_id/reserve_spot', to: 'spots#create'

      resources :faq_items, only: :show
      resources :feedbacks, only: :create
      resources :faq_groups, only: :index

      resources :designer_ndas, only: [:index, :create]

      resources :start_notification_requests, only: [:create]

      resources :users, only: :update
      resources :payments, only: :index
      resources :earnings, only: :index
      resources :payout_min_amounts, only: :index

      resources :reviews, only: [:index, :create]
      resources :payouts, only: [:index, :create]
      resources :nda_prices, only: [:index]

      resources :winners, only: [:create]

      resources :discounts, only: [:show]

      resources :brands, only: [:index, :show] do
        get :all, on: :collection
      end

      namespace :public do
        resources :vat_rates, only: [:index]
        resources :brand_examples, only: [:index]
        resources :technical_drawings, only: [:create]
        resources :additional_design_prices, only: [:index]
        resources :products, only: [:index]
        resources :product_categories, only: [:index]
        resource  :testimonial, only: [:show]

        resources :reviews, only: [:index]
        resources :designers, only: [:index, :show]

        resources :projects, controller: 'project_wizard', only: [:show, :create, :update]

        resources :projects, only: [] do
          resources :project_additional_documents, only: [:create, :destroy]
          resources :project_stock_images, only: [:create, :destroy]
          resources :inspirations, only: [:create, :destroy]
          resources :existing_designs, only: [:create, :destroy]
        end

        resources :brands, only: [] do
          resources :competitors, only: [:create, :destroy]
        end
      end
    end

    namespace :v2 do
      namespace :client do
        resources :projects, only: [:show, :create, :update]
        resources :uploaded_files, only: [:create]
      end

      resources :brands, only: [:index]
      resources :brand_examples, only: [:index]
      resources :nda_prices, only: [:index]
      resources :vat_rates, only: [:index]
      resources :products, only: [:index]
      resources :discounts, only: [:show]
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  get 'receipts/:payment_id', to: 'receipts#show'
  get 'continue_brief', to: 'deeplinks#continue_brief'
  get 'new_project_success/:project_id', to: 'deeplinks#stripe_callback'
  get 'emails/abandoned_cart/unsubscribe', to: 'emails#unsubscribe_abandoned_cart'
  get 'finish_project', to: 'deeplinks#retargeting'

  root to: 'welcome#index'
  get '*path', to: 'welcome#index'
end
