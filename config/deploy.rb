sh "ssh-add"
# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "techbang_rails101"
set :repo_url, "git@github.com:myohmy10420/techbang_rails101.git"
set :deploy_to, "/home/app/techbang_rails101"

# rbenv setting
set :rbenv_type, :user
set :rbenv_ruby, "2.2.7"
set :rbenv_path, "/usr/local/rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :keep_releases, 5

after 'deploy:restart', 'unicorn:duplicate'
