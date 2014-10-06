#!/usr/bin/env puma
#
# App server configuration

APP_ROOT = File.expand_path '../../', __FILE__
RAILS_ENV = ENV['RAILS_ENV'] || 'development'

# Define thread counts, so that we don't need to remember the order in
# `threads`.
MIN_THREADS = 0
MAX_THREADS = 16

# HTTP Server configuration
directory "#{APP_ROOT}/current"
environment RAILS_ENV
pidfile "#{APP_ROOT}/shared/pids/puma.pid"
state_path "#{APP_ROOT}/shared/pids/puma.state"
stdout_redirect "#{APP_ROOT}/shared/log/puma.access.log", "#{APP_ROOT}/shared/log/puma.error.log", true
threads MIN_THREADS, MAX_THREADS
bind "unix://#{APP_ROOT}/shared/pids/puma.sock"
#ssl_bind '127.0.0.1', '9292', { key: path_to_key, cert: path_to_cert }
tag 'waxpoetic'

# Cluster configuration
workers 2
prune_bundler true
worker_timeout 30
#activate_control_app "unix://#{APP_ROOT}/shared/pids/pumactl.sock", no_token: true
