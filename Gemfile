# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'activeadmin', '~> 3.2'
gem 'acts_as_tenant'
gem 'bootsnap', require: false
gem 'chartkick', '~> 3.3.0'
gem 'devise'
gem 'foreman'
gem 'groupdate'
gem 'image_processing', '>= 1.2'
gem 'jbuilder'
gem 'json', '2.7.1'
gem 'kaminari'
gem 'pg', '~> 1.2'
gem 'puma', '~> 6.0'
gem 'rails', '~> 7.1.0'
gem 'ransack', '~> 4.1', '>= 4.1.1'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sassc'
gem 'simple_form'
gem 'simple_form-tailwind'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'
gem 'tzinfo-data',
    platforms: %i[mingw mswin x64_mingw jruby]
gem 'yaml'
gem "railsui", github: "getrailsui/railsui", branch: "main"
gem 'name_of_person', '~> 1.1', '>= 1.1.3'

group :development, :test do
  gem 'annotate'
  gem 'binding_of_caller'
  gem 'cpf_faker'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'json_matchers'
  gem 'pry-byebug'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0'
  gem 'rswag-specs'
  gem 'rubocop', require: false
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubycritic', require: false
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov'
  gem 'simplecov-json'
end

group :development do
  gem 'better_errors'
  gem 'letter_opener_web'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rack-mini-profiler', require: false
  gem 'rails_layout'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'rspec-benchmark'
  gem 'selenium-webdriver', '~> 4.10'
  gem 'webdrivers', '~> 5.3'
end

gem 'sidekiq', '~> 7.2'

# Use Redis for Action Cable
gem "redis", "~> 4.0"
