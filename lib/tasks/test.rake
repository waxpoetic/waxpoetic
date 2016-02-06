begin
  require 'rspec/core/rake_task'

  namespace :test do
    desc 'Run all unit tests'
    RSpec::Core::RakeTask.new :unit do |t|
      units = Dir['spec/*'].reject do |path|
        path =~ /features|integration/
      end.map do |path|
        File.basename(path)
      end.join(',')
      t.files = "spec/{#{units}}/**/*_spec.rb"
    end

    desc 'Run all integration tests'
    RSpec::Core::RakeTask.new :integration do
      t.files = 'spec/{features,integration}/**/*_spec.rb'
    end
  end

  desc 'Run all tests'
  RSpec::Core::RakeTask.new :test
rescue LoadError; end
