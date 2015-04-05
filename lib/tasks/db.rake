desc "Set up the database from scratch"
task :db => %w(db:reset db:migrate db:seed)

namespace :db do
  task :export => :environment do
    Exportable.models.map(&:export_to_fixtures)
  end

  task :disconnect do
    sh %{psql -c "SELECT pid, (SELECT pg_terminate_backend(pid)) as killed from pg_stat_activity WHERE state LIKE 'idle';"}
  end
end
