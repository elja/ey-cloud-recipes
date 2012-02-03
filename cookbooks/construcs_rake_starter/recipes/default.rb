#
# Cookbook Name:: construcs_rake_starter
# Recipe:: default
#
app_dir="/data/Construcs/"
app_dir_shared=app_dir + "shared"
app_dir_current=app_dir + "current"
env="staging"

ey_cloud_report "create sym links" do
  message "create sym links"
end

execute "bundler install" do
  command "gem install bundler"
end

execute "create sym links for uploads" do
  command "ln -nfs #{app_dir_shared}/uploads #{app_dir_current}/public/uploads"
end

execute "create sym links for sunspot" do
  command "ln -nfs #{app_dir_shared}/solr #{app_dir_current}/solr"
end

ey_cloud_report "starting sunspot" do
  message "starting sunspot"
end

execute "sunspot start" do
  command "cd #{app_dir_current} && RAILS_ENV=#{env} bundle exec rake sunspot:solr:start"
end

ey_cloud_report "starting delayed jobs" do
  message "starting delayed jobs"
end

execute "delayed job start" do
  command "cd #{app_dir_current} && RAILS_ENV=#{env} ./script/delayed_job start"
end

ey_cloud_report "sunspot reindex" do
  message "sunspot reindex"
end

execute "sunspot reindex" do
  command "cd #{app_dir_current} && RAILS_ENV=#{env} bundle exec rake sunspot:reindex"
end
