#
# Set this application up for deployment on Heroku.
#

# `heroku create`

%w(
  heroku-postgresql:hobby-dev
  heroku-redis:hobby-dev
  sendgrid:starter
  papertrail:choklad
  newrelic:wayne
  librato:development
  pingdom:starter
  airbrake:free_heroku
).each do |addon|
  `heroku addons:create #{addon} --app waxpoetic-staging`
end

`heroku buildpacks:add https://github.com/gunpowderlabs/buildpack-ruby-rake-deploy-tasks --app waxpoetic-staging`

`heroku config:set DEPLOY_TASKS='db:migrate db:index' --app waxpoetic-staging`
