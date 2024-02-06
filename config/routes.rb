require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :admin_users,
             ActiveAdmin::Devise.config
  devise_for :users, {
    sessions: 'users/sessions'
  }

  ActiveAdmin.routes(self)

  root to: 'external/home#index'

  namespace :manager do
    resources :technical_reports, only: :index
    resource :company
    resources :clients do
      resources :technical_reports, only: %i[create show]
    end
    resources :users
    resources :coolers do
      scope module: :coolers do
        resources :maintenances
      end
    end
    resources :maintenances
    get '', to: 'home#index', as: :home
  end

  scope module: :external do
    get '', to: 'home#index', as: :home
    get 'stimulus', to: 'home#stimulus', as: :stimulus
  end
end
