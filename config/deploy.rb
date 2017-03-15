lock '3.8.0'
APP_CONFIG = YAML.load_file("config/config.yml")["production"]

set :passenger_restart_with_touch, true
set :repo_url, APP_CONFIG['git_repo']
set :application, "DbjohnCom"
set :deploy_to, APP_CONFIG['cap_applicationdir']
set :default_env, {
    'PATH' => "#{deploy_to}/bin:$PATH",
    'GEM_HOME' => "#{deploy_to}/gems",
    'RUBYLIB' => "#{deploy_to}/lib"
}
set :tmp_dir, "/home/#{APP_CONFIG['cap_user']}/tmp"
server APP_CONFIG['domain'], user: APP_CONFIG['cap_user'], roles: %w{app db web}

set :whenever_command,      ->{ [:bundle, :exec, :whenever] }
set :whenever_identifier, ->{ "DJ_#{fetch(:stage)}" }

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/config.yml', )

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/pics', 'public/ckeditor_assets')

set :keep_releases, 2