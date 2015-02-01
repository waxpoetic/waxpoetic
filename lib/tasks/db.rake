require 'pg'

desc "Set up the database"
task :db => %w(db:reset db:migrate db:seed)

namespace :db do
  desc 'Copy data from the classic DB to this one'
  task :import do
    classic = PG.connect dbname: 'waxpoetic_classic'
    options = 'HEADER FORMAT csv'

    %w(artists releases).each do |table|
      filename = "#{Rails.root}/tmp/#{table}.csv"
      classic.execute "COPY #{table} TO '#{filename}' WITH #{options};"
      ActiveRecord::Base.connection.execute %(
        COPY #{table} FROM '#{filename}' WITH #{options};
      )
    end
  end
end
