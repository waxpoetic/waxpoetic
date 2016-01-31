namespace :lint do
  desc 'Run JavaScript lint checks'
  task :js do
    sh 'jshint app/assets/javascripts'
  end

  desc 'Run ECMAScript lint checks'
  task :es6 do
    sh 'eslint app/assets/javascripts'
  end

  desc 'Run SCSS lint checks'
  task :scss do
    sh 'scss-lint app/assets/stylesheets'
  end

  begin
    require 'rubocop/rake_task'

    desc 'Run Ruby lint checks'
    RuboCop::RakeTask.new :ruby
  rescue LoadError
    task :ruby do
      puts 'Skipping Ruby lint checks since RuboCop is not installed'
    end
  end
end

task lint: %w(lint:ruby lint:js lint:es6 lint:scss)
