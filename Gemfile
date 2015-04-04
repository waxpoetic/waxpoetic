source 'https://rubygems.org'

# Framework
gem 'rails', '~> 4.2'
gem 'spree', github: 'spree/spree'
gem 'spree_gateway', github: 'spree/spree_gateway'
gem 'devise'
gem 'email_validator'
gem 'friendly_id'
gem 'controller_resources'
gem 'active_model_serializers'
gem 'carrierwave'
gem 'high_voltage'
gem 'draper'
gem 'authority'
gem 'redcarpet'
gem 'simple_form'
gem 'nested_form'
gem 'pg'
gem 'sidekiq'
gem 'aws-sdk', '~> 1.27'
gem 'mini_magick'
gem 'fog'
gem 'geocoder'
gem 'soundcloud'
gem 'bitly'
gem 'rails-assets-marked', source: 'https://rails-assets.org'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier', '~> 1.3'
gem 'turbolinks'
gem 'foundation-rails'
gem 'jquery-turbolinks'
gem 'autoprefixer-rails'

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'annotate'
  gem 'web-console', '~> 2.0'
  gem 'awesome_print'
  gem 'spring', '~> 1.3'
  gem 'spring-commands-rspec'
  gem 'rubocop'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec-rails',  require: false
  gem 'email_spec',   require: false
  gem 'capybara',     require: false
  gem 'poltergeist',  require: false
  gem 'factory_girl'
end

group :staging, :production do
  gem 'rack-cache'
  gem 'redis-rails'
  gem 'redis-session-store'
  gem 'asset_sync'
  gem 'puma'
end
