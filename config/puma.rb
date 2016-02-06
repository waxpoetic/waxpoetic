#!/usr/bin/env puma
#
# App server configuration for waxpoeticrecords.com, in accordance with
# the recommended guidelines for deploying Rails apps on Heroku with
# Puma.

WEB_CONCURRENCY = ENV.fetch('WEB_CONCURRENCY') { 2 }
MAX_THREADS = ENV.fetch('MAX_THREADS') { 5 }
PORT = ENV.fetch('PORT') { 3000 }
RACK_ENV = ENV.fetch('RACK_ENV') { 'development' }

workers WEB_CONCURRENCY
threads MAX_THREADS, MAX_THREADS

preload_app!

port PORT
environment RACK_ENV

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
