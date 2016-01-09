namespace :release do
  task :bump do |_, args|
    args.with_defaults level: 'patch'
    system "bin/semver increment #{args[:level]}"
    system %(git commit -am "Release $(bin/semver tag)")
  end

  task :tag do |_, _args|
    system %(git tag $(bin/semver tag) -m "Release $(bin/semver tag)")
  end

  task :push do |_, _args|
    system 'git push --tags'
  end

  desc 'Release major version'
  task :major do
    Rake::Task['release'].invoke level: 'major'
  end

  desc 'Release minor version'
  task :minor do
    Rake::Task['release'].invoke level: 'minor'
  end

  desc 'Release patch version'
  task :patch do
    Rake::Task['release'].invoke level: 'patch'
  end
end

desc 'Deploy and release this application (default level: patch)'
task :release, [:level] => %w(
  release:bump
  release:tag
  release:push
)
