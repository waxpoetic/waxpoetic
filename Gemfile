source 'https://rubygems.org'
source 'https://rails-assets.org'
ruby '2.1.4'

gem 'rails', '~> 4.1'

gem 'pg'
gem 'active_model_serializers'
gem 'devise'
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'email_validator'
gem 'friendly_id'

gem 'spree', '~> 2.3'
gem 'spree_gateway'

gem 'high_voltage'
gem 'haml-rails'
gem 'draper'
gem 'authority'
gem 'decent_exposure'
gem 'redcarpet'
gem 'simple_form'
gem 'responders'
gem 'nested_form'

gem 'soundcloud'
gem 'bitly'

gem 'rails-assets-marked'

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier', '~> 1.3'
gem 'turbolinks'
gem 'foundation-rails'
gem 'jquery-turbolinks'
gem 'autoprefixer-rails'

gem 'activejob'
gem 'activemodel-globalid', github: 'rails/activemodel-globalid'
gem 'sidekiq'

gem 'puma'

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'annotate'
  gem 'web-console'
  gem 'awesome_print'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec-rails', require: false
  gem 'email_spec', require: false
  gem 'capybara', require: false
  gem 'poltergeist', require: false
  gem 'factory_girl'
end

group :staging, :production do
  gem 'rack-cache'
  gem 'redis-rails'
  gem 'redis-session-store'
  gem 'asset_sync'
end
