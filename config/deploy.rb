# Config valid only for Capistrano 3.1
lock '3.2.1'

# Use the open-source repo.
set :application, 'waxpoetic'
set :repo_url, 'git@github.com:waxpoetic/waxpoeticrecords.com.git'

# Deploy to /srv
set :deploy_to, '/srv/waxpoetic'

# Log level
set :log_level, :info

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, {
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  aws_cdn_distro_id: ENV['AWS_CDN_DISTRO_ID']
}

# Use the current version of Ruby
set :chruby_ruby, RUBY_VERSION

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app) do
      sudo :restart, 'waxpoetic'
    end
  end

  desc "Run AssetSync after compiling assets."
  task :sync_assets do
    on roles(:web) do
      within release_path do
        rake 'assets:sync'
      end
    end
  end

  desc "Clear the Rails cache"
  task :clear_cache do
    on roles(:web) do
      within release_path do
        rake 'cache:clear'
      end
    end
  end

  after :publishing, :restart
  after :assets, :sync_assets
  after [:restart, :clear_cache], :clear_cache
end
