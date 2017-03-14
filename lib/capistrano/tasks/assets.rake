set :keep_assets, 2
set :assets_dependencies, %w(app/assets lib/assets vendor/assets)
# Clear existing task so we can replace it rather than "add" to it.
Rake::Task["deploy:compile_assets"].clear 
class PrecompileRequired < StandardError; end

namespace :deploy do
  desc 'Compile assets'
  task :compile_assets => [:set_rails_env] do
    # invoke 'deploy:assets:precompile'
    invoke 'deploy:assets:copy_manifest'
    invoke 'deploy:assets:precompile_local'
    invoke 'deploy:assets:backup_manifest'
  end

  namespace :assets do
    local_dir = "./public/assets/"

    # Download the asset manifest file so a new one isn't generated. This makes
    # the app use the latest assets and gives Sprockets a complete manifest so
    # it knows which files to delete when it cleans up.
    desc 'Copy assets manifest'
    task copy_manifest: [:set_rails_env] do
      on roles(fetch(:assets_roles, [:web])) do
        remote_dir = "#{host.user}@#{host.hostname}:#{shared_path}/public/assets/"

        run_locally do
          begin
            execute "mkdir #{local_dir}"
            execute "scp '#{remote_dir}.sprockets-manifest-*' #{local_dir}"
          rescue
            # no manifest yet
          end
        end
      end
    end

    # desc "Precompile assets locally and then rsync to web servers"
    # task :precompile_local do
    #   # compile assets locally
    #   run_locally do
    #     execute "RAILS_ENV=#{fetch(:stage)} bundle exec rake assets:precompile"
    #   end
    #   # rsync to each server
    #   local_dir = "./public/assets/"
    #   on roles( fetch(:assets_roles, [:web]) ) do
    #     # this needs to be done outside run_locally in order for host to exist
    #     remote_dir = "#{host.user}@#{host.hostname}:#{release_path}/public/assets/"
    #
    #     run_locally { execute "rsync -av --delete #{local_dir} #{remote_dir}" }
    #     execute "chmod 775 -R #{release_path}/public/assets/"
    #   end
    #   # clean up
    #   # run_locally { execute "rm -rf #{local_dir}" }
    # end


    desc "Precompile assets: https://coderwall.com/p/aridag/only-precompile-assets-when-necessary-rails-4-capistrano-3"
    task :precompile_local do
      on roles( fetch(:assets_roles, [:web]) ) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            begin
              # find the most recent release
              latest_release = capture(:ls, '-xr', releases_path).split[1]

              # precompile if this is the first deploy
              raise PrecompileRequired unless latest_release

              latest_release_path = releases_path.join(latest_release)

              # precompile if the previous deploy failed to finish precompiling
              execute(:ls, latest_release_path.join('assets_manifest_backup')) rescue raise(PrecompileRequired)

              fetch(:assets_dependencies).each do |dep|
                # execute raises if there is a diff
                execute(:diff, '-Naur', release_path.join(dep), latest_release_path.join(dep)) rescue raise(PrecompileRequired)
              end

              info("Skipping asset precompile, no asset diff found")

            rescue PrecompileRequired
              remote_dir = "#{host.user}@#{host.hostname}:#{latest_release_path}/public/assets/"
              run_locally do
                execute "RAILS_ENV=#{fetch(:stage)} bundle exec rake assets:precompile"
                execute "rsync -av --delete #{local_dir} #{remote_dir}"
              end
              execute "chmod 775 -R #{latest_release_path}/public/assets/"
            end
          end
        end
      end
    end
  end
end