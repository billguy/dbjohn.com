desc 'copy ckeditor nondigest assets'
task :copy_nondigest_assets do
  on roles :app do
    within fetch(:release_path) do
      with rails_env: fetch(:rails_env) do
        execute :rake, "ckeditor:copy_nondigest_assets"
      end
    end
  end
end
after 'deploy:assets:precompile', 'copy_nondigest_assets'