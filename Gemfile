source 'https://rubygems.org'
ruby '2.3.0'

# framework
gem 'rails', '~> 4.2'
gem 'rack-timeout'
gem 'rack-canonical-host'
gem 'pg'
gem 'devise'
gem 'administrate', github: 'thoughtbot/administrate'

# api
gem 'controller_resources'
gem 'high_voltage'
gem 'active_model_serializers'
gem 'friendly_id'

# models
gem 'email_validator'
gem 'refile', require: 'refile/rails'
gem 'refile-mini_magick', require: 'refile/mini_magick'
gem 'active_model-jobs'

# views
gem 'draper'
gem 'simple_form'
gem 'haml-rails'
gem 'title'

# services
gem 'gibbon'
gem 'koala'
gem 'bitly'
gem 'soundcloud'

# assets
gem 'sass-rails'
gem 'sprockets-es6', github: 'tubbo/sprockets-es6', branch: 'loader'
gem 'uglifier'
gem 'turbolinks', github: 'rails/turbolinks'
gem 'jquery-turbolinks'
gem 'autoprefixer-rails'
gem 'bourbon'
gem 'bitters'
gem 'neat'

source 'https://rails-assets.org' do
  gem 'rails-assets-marked'
  gem 'rails-assets-trix'
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
  gem 'yard'
end

group :test do
  gem 'rspec-rails',  require: false
  gem 'email_spec',   require: false
  gem 'capybara',     require: false
  gem 'poltergeist',  require: false
end

group :production do
  gem 'rack-cache'
  gem 'redis-rails'
  gem 'puma'
  gem 'sidekiq'
  gem 'rails_12factor'
  gem 'refile-s3', require: 'refile/s3'
end
