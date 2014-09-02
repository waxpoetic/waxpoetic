server 'waxpoeticrecords.com', \
  user: 'app',
  roles: %w{web app db},
  rails_env: 'production'

namespace :deploy do
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

  after :assets, :sync_assets
  after [:restart, :clear_cache], :clear_cache
end
