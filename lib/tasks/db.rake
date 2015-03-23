desc "Set up the database from scratch"
task :db => %w(db:reset db:migrate db:seed)

namespace :db do
  task :export => :environment do
    [Artist, Release].map(&:export_to_fixtures)
  end
end
