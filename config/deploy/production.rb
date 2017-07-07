role :app, "kenny.ocbs.pro"
role :web, "kenny.ocbs.pro"
role :db,  "kenny.ocbs.pro"

server 'kenny.ocbs.pro', user: 'deploy', roles: %w[web app db]

set :branch, 'master'
set :rails_env, 'production'
