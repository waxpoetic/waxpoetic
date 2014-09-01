namespace :doc do
  task annotations: :environment do
    sh 'annotate'
  end
end

task :annotations => ['doc:annotations']
