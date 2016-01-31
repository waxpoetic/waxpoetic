begin
  require 'rspec/core/rake_task'

  namespace :test do
    desc ''
    RSpec::Core::RakeTask.new :all

    desc 'Run all unit tests'
    RSpec::Core::RakeTask.new :units do |t|
      units = Dir['spec/*'].reject do |path|
        path =~ /features/
      end.map do |path|
        File.basename(path)
      end.join(',')
      t.files = "spec/{#{units}}/**/*_spec.rb"
    end

    desc 'Run all feature tests'
    RSpec::Core::RakeTask.new :features do
      t.files = 'spec/features/**/*_spec.rb'
    end
  end

  desc 'Run all tests'
  task test: %w(test:all)
rescue LoadError;end
