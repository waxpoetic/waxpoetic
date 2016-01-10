source 'https://rubygems.org'

# Framework
gem 'rails', '~> 4.2'
gem 'devise'
gem 'email_validator'
gem 'friendly_id'
gem 'controller_resources'
gem 'active_model_serializers'
gem 'active_model-jobs'
gem 'high_voltage'
gem 'draper'
gem 'redcarpet'
gem 'simple_form'
gem 'pg'
gem 'mini_magick'
gem 'soundcloud'
gem 'bitly'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier', '~> 1.3'
gem 'turbolinks'
gem 'foundation-rails'
gem 'jquery-turbolinks'
gem 'autoprefixer-rails'
gem 'gibbon'
gem 'administrate'
gem 'haml-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-marked'
end

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'annotate'
  gem 'web-console', '~> 2.0'
  gem 'awesome_print'
  gem 'semver'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rubocop'
end

group :test do
  gem 'rspec-rails',  require: false
  gem 'email_spec',   require: false
  gem 'capybara',     require: false
  gem 'poltergeist',  require: false
end

group :staging, :production do
  gem 'rack-cache'
  gem 'redis-rails'
  gem 'puma'
  gem 'sidekiq'
  gem 'rails_12factor'
end
