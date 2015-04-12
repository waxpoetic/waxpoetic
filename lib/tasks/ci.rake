namespace :ci do
  desc "Deploy the application with CircleCI and Chef"
  task deploy: :environment do
    WaxPoetic::Deployment.create Rails.application.secrets.circle_token
  end
end
