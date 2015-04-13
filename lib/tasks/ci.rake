namespace :ci do
  desc "Deploy the application with CircleCI and Chef"
  task deploy: :environment do
    api_token = Rails.application.secrets.circle_token
    deployment = WaxPoetic::Deployment.create api_token, ENV['DEPLOY_ENV']
    exit 0 if deployment.persisted?
    puts "Deployment failed: #{deployment.errors.full_messages.to_sentence}"
    exit 1
  end
end
