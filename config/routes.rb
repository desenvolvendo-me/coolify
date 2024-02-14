require 'sidekiq/web'
Rails.application.routes.draw do
	get 'about', to: 'page#about'
	get 'admin/account_preferences', to: 'page#account_preferences'
	get 'admin/account_notifications', to: 'page#account_notifications'
	get 'admin/account_payouts', to: 'page#account_payouts'
	get 'admin/account_payment_methods', to: 'page#account_payment_methods'
	get 'admin/contact', to: 'page#contact'
	get 'admin/terms', to: 'page#terms'
	get 'admin/privacy_policy', to: 'page#privacy_policy'
	get 'admin/api', to: 'page#api'
	get 'admin/changelog', to: 'page#changelog'
	get 'admin/help_center', to: 'page#help_center'
	get 'admin/edit_booking', to: 'page#edit_booking'
	get 'admin/booking', to: 'page#booking'
	get 'admin/new_booking', to: 'page#new_booking'
	get 'admin/bookings', to: 'page#bookings'
	get 'admin/insights', to: 'page#insights'
	get 'admin/calendar', to: 'page#calendar'
	get 'admin/inbox', to: 'page#inbox'
	get 'admin/properties', to: 'page#properties'
	get 'admin/dashboard', to: 'page#dashboard'
  if Rails.env.development? || Rails.env.test?
    mount Railsui::Engine, at: "/railsui"
  end

  # Inherits from Railsui::PageController#index
  # To overide, add your own page#index view or change to a new root
  # Visit the start page for Rails UI any time at /railsui/start
  root action: :index, controller: "railsui/page"

  devise_for :users
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :admin_users,
             ActiveAdmin::Devise.config
  # devise_for :users, {
  #   sessions: 'users/sessions'
  # }

  ActiveAdmin.routes(self)
  #
  # root to: 'external/home#index'

  namespace :manager do
    resource :company
    resources :users
    resources :clients do
      scope module: :clients do
        resources :coolers
      end
    end
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
