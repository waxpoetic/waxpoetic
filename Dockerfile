##
# Container setup
##

# begin with Ruby 2.2.2 base image
FROM ruby:2.2.2

# update build toolchain and package versions
RUN apt-get update -qq && apt-get install -y build-essential

# install hard dependencies
RUN apt-get install -y libpq-dev libxml2-dev libxslt1-dev nodejs

# set up the working directory
ENV APP_HOME /srv
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# install the application
ADD . $APP_HOME
RUN ./bin/setup
