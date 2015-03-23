desc "Set up the database from scratch"
task :db => %w(db:reset db:migrate db:seed)

namespace :db do
  task :export => :environment do
    Exportable.models.map(&:export_to_fixtures)
  end
end
