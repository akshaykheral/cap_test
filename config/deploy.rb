# config valid only for Capistrano 3.1
lock '3.2.1'


# rbenv
set :rvm_type, :auto
set :rvm_ruby_version, '2.0.0-p481'

# bundler
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }

#set :bundle_dir, -> { path: "/usr/bin/bundle" }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
# Default value for :scm is :git
set :scm, :git
set :repo_url, 'git@github.com:akshaykheral/cap_test.github'
set :branch, 'master'
set :repo_subdir, "cap_test"
set :deploy_to, '/var/www/rails_apps/xxx'
# Default value for keep_releases is 5
set :keepreleases, 5

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
#set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{var/www/rails_apps/xxx}
# Default value for default_env is {}
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }
#set :default_env, { path: "/opt/ruby/bin:$PATH" }


# set :keep_releases, 5
set :whenever_identifier, ->{ "store" }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end



  desc "Update the crontab file"
  #puts "Update the crontab file".blue.on_red
  task :update_crontab do
    run "whenever --update-crontab store"
    # _cset(:whenever_update_flags) { "–update-crontab #{fetch :whenever_identifier} –set #{fetch :whenever_variables} –user www-data" }
  end
  
  
  after "deploy:symlink:linked_dirs", "deploy:update_crontab"  
  
  namespace :deploy do  
    desc "Update the crontab file"  
    task :update_crontab do
      on roles(:db) do
        run "cd release_path.join && whenever --update-crontab store"
      end  
    end
  end  

  after :publishing, :restart
  after :finishing, 'deploy:cleanup'
end