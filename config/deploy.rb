require 'bundler/capistrano'
require "whenever/capistrano"

APP_CONFIG = YAML.load_file("config/config.yml")["production"]

set :application, "DbjohnCom" #change this to your Rails app name
set :repository,  APP_CONFIG['git_repo']

set :user, APP_CONFIG['cap_user']
set :domain, APP_CONFIG['domain']
set :applicationdir, APP_CONFIG['cap_applicationdir']

set :deploy_to, applicationdir
set :default_environment, {
    'PATH' => "#{deploy_to}/bin:$PATH",
    'GEM_HOME' => "#{deploy_to}/gems",
    'RUBYLIB' => "#{deploy_to}/lib"
}
set :rails_env, "production"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :rake, 'bundle exec rake'

role :web, domain                           # Your HTTP server, Apache/etc
role :app, domain                           # This may be the same as your 'Web' server
role :db,  domain, :primary => true         # This is where Rails migrations will run

set :deploy_via, :export
set :keep_releases, 2
set :use_sudo, false

after "deploy", "deploy:cleanup"

before "deploy:assets:precompile", "gems:install"
namespace :gems do
  desc "Install gems"
  task :install, :roles => :app do
    run "cd #{current_release} && bundle install --without development test"
  end
end

before "deploy:assets:precompile", "deploy:symlink_db"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/config.yml #{release_path}/config/config.yml"
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/shared/system/ckeditor_assets #{release_path}/public"
    run "ln -nfs #{deploy_to}/shared/system/pics #{release_path}/public"
  end
  desc "Restart nginx"
  task :restart do
    run "#{deploy_to}/bin/restart"
  end
end

after 'deploy:publishing', 'deploy:restart'

after "deploy", "refresh_sitemaps"
task :refresh_sitemaps do
  run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake sitemap:refresh"
end

desc 'copy ckeditor nondigest assets'
task :copy_nondigest_assets, roles: :app do
  run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} ckeditor:copy_nondigest_assets"
end
after 'deploy:assets:precompile', 'copy_nondigest_assets'

load 'deploy/assets'
