desc "Set up the database"
task :db => %w(db:reset db:migrate db:seed)
