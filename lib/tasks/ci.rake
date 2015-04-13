namespace :ci do
  desc "Deploy the application with CircleCI and Chef"
  task deploy: :environment do
    api_token = Rails.application.secrets.circle_token
    WaxPoetic::Deployment.create api_token, ENV['DEPLOY_ENV']
  end
end
