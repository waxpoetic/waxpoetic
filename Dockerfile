##
# Container setup
##

# begin with Ruby 2.2.2 image
FROM ruby:2.2.0

# update build toolchain and package versions
RUN apt-get update -qq && apt-get install -y build-essential

# postgresql client library
RUN apt-get install -y libpq-dev

# nokogiri hard dependencies
RUN apt-get install -y libxml2-dev libxslt1-dev

# javascript runtime
RUN apt-get install -y nodejs

# set up the working directory at /srv
ENV APP_HOME /srv
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# install dependencies to /srv/vendor/bundle
ADD Gemfile* $APP_HOME/
RUN bin/bundle install

# install the application codebase
ADD . $APP_HOME
