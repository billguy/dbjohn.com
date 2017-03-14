lock '3.7.1'
APP_CONFIG = YAML.load_file("config/config.yml")["production"]

set :passenger_restart_with_touch, true
set :repo_url, APP_CONFIG['git_repo']
set :application, "DbjohnCom"
set :default_environment, {
    'PATH' => "#{APP_CONFIG['cap_applicationdir']}/bin:$PATH",
    'GEM_HOME' => "#{APP_CONFIG['cap_applicationdir']}/gems",
    'RUBYLIB' => "#{APP_CONFIG['cap_applicationdir']}/lib"
}

server APP_CONFIG['domain'], user: APP_CONFIG['cap_user'], roles: %w{app db web}

set :whenever_command,      ->{ [:bundle, :exec, :whenever] }
set :whenever_identifier, ->{ "DJ_#{fetch(:stage)}" }

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/config.yml', )

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/pics', 'public/ckeditor_assets')

set :keep_releases, 2