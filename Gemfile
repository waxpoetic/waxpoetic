source 'https://rubygems.org'
ruby '2.1.3'

gem 'rails', '~> 4.1'
gem 'pg'
gem 'active_model_serializers'
gem 'puma'
gem 'activejob'
gem 'activemodel-globalid', github: 'rails/activemodel-globalid'
gem 'sidekiq'
gem 'sass-rails'
gem 'coffee-rails'
gem 'foundation-rails'
gem 'uglifier', '~> 1.3'
gem 'devise'
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'spree', '~> 2.3'
gem 'spree_gateway'
gem 'high_voltage'
gem 'haml-rails'
gem 'draper'
gem 'email_validator'
gem 'authority'
gem 'decent_exposure'
gem 'redcarpet'
gem 'jquery-turbolinks'
gem 'turbolinks'

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'annotate'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-chruby'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec-rails', require: false
  gem 'email_spec', require: false
  # TODO: Re-enable when we have Capybara specs again.
  #gem 'capybara', require: false
  #gem 'poltergeist', require: false
end

group :production do
  gem 'rack-cache'
  gem 'redis-rails'
  gem 'asset_sync'
end
