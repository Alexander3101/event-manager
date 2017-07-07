lock "3.8.2"

set :application, "event-manager"
set :repo_url, "git@github.com:OCBS/event-manager.git"

set :deploy_via, :remote_cache
set :deploy_to, '/home/deploy/projects/kenny.ocbs.pro'

set :linked_files, %w[config/database.yml config/secrets.yml]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets]

set :keep_releases, 2

# for sync
set :assets_dir, 'public/system'
set :local_assets_dir, 'public'
set :db_remote_clean, true

set :rbenv_type, :user
set :rbenv_ruby, '2.3.4'

set :ssh_options, forward_agent: false

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
