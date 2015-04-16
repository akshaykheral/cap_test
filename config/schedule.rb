RAILS_ROOT = File.dirname(__FILE__) + '/..'

every :day, :at => '1:37pm', :roles => [:app] do
  rake 'app:task' # will only be added to crontabs of :app servers
end

every :hour, :roles => [:db] do
  rake 'db:task' # will only be added to crontabs of :db servers
end

every :day, :at => '12:02am' do
  command "run_this_everywhere" # will be deployed to :db and :app servers
end

every :friday, :at => "4am" do
	command "rm -rf #{RAILS_ROOT}/tmp/cache"
	runner "Cart.remove_abandoned"
end


# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
