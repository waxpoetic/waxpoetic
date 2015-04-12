require 'wax_poetic/deployment'

namespace :ci do
  desc "Deploy the application with CircleCI and Chef"
  task deploy: :environment do
    WaxPoetic::Deployment.create WaxPoetic.secrets.circle_token
  end
end
