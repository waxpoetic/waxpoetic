namespace :db do
  desc 'Create fixtures from exportable model data'
  task export: :environment do
    Exportable.models.map(&:to_fixture)
  end
end
