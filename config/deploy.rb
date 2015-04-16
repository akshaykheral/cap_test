set :application, 'cap_test'
set :repo_url, 'git@github.com:akshaykheral/cap_test.git'

role :app, "52.74.3.7"
role :web, "52.74.3.7"
role :db,  "52.74.3.7", :primary => true

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

after "deploy:symlink", "deploy:update_crontab"