every :day, :at => '1:37pm', :roles => [:app] do
  rake 'app:task' # will only be added to crontabs of :app servers
end

every :hour, :roles => [:db] do
  rake 'db:task' # will only be added to crontabs of :db servers
end

every :day, :at => '12:02am' do
  command "run_this_everywhere" # will be deployed to :db and :app servers
end