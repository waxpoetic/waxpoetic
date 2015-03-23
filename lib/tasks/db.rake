desc "Set up the database from scratch"
task :db => %w(db:reset db:migrate db:seed)

namespace :db do
  task :import => :environment do
    file = "#{Rails.root}/db/classic.sql"
    config = Rails.configuration.database_configuration
    db = config[Rails.env]['database']
    sh "cat #{file} | psql #{db}"
  end

  task :export => :environment do
    Legacy.export!
    puts 'exported data to fixtures'
  end
end
