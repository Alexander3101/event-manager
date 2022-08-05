# config valid only for current version of Capistrano
lock '3.6.1'

set :default_stage, "staging"
set :stages, %w(production)

set :use_sudo, false
set :group_writable, false

# setup rvm
set :rvm_type, :user
set :rvm_ruby_version, '3.0.0'

# setup repo details
set :scm, :git
set :repo_url, "git@github.com:Alexander3101/event-manager.git"
set :deploy_via, :remote_cache
set :scm_verbose, true

# Puma settings
set :puma_bind,       -> {"unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"}
set :puma_state,      -> {"#{shared_path}/tmp/pids/puma.state"}
set :puma_pid,        -> {"#{shared_path}/tmp/pids/puma.pid"}
set :puma_access_log, -> {"#{release_path}/log/puma.error.log"}
set :puma_error_log,  -> {"#{release_path}/log/puma.access.log"}
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

# files we want symlinking to specific entries in shared
set :linked_files, %w{config/database.yml config/secrets.yml config/ldap.yml}

# dirs we want symlinking to shared
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}

