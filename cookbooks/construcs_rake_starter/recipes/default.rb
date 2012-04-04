#
# Cookbook Name:: construcs_rake_starter
# Recipe:: default
#
app_dir="/data/Construcs/"
app_dir_shared=app_dir + "shared"
app_dir_current=app_dir + "current"

shared_path = add_dir_shared
current_path = app_dir_current

env="staging"

ey_cloud_report "create sym links" do
  message "create sym links"
end

execute "bundler install" do
  command "gem install bundler"
end

execute "create sym links for uploads" do
  command "ln -nfs #{shared_path}/uploads   #{current_ath}/public/"
  command "ln -nfs #{shared_path}/solr/data #{current_path}/solr/"
  command "ln -nfs #{shared_path}/solr/lib  #{current_path}/solr/"
  command "ln -nfs #{shared_path}/solr/pids #{current_path}/solr/"
  command "ln -nfs #{shared_path}/solr/conf/elevate.xml #{current_path}/solr/conf/"
  command "ln -nfs #{shared_path}/solr/conf/solrconfig.xml #{current_path}/solr/conf/"
  command "ln -nfs #{shared_path}/solr/conf/*.txt #{current_path}/solr/conf/"
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


ey_cloud_report "precompile assets" do
  message "precompile assets"
end

execute "assets precompile" do
  command "cd #{app_dir_current} && RAILS_ENV=#{env} bundle exec rake assets:precompile"
end

ey_cloud_report "migrate" do
  message "migrate"
end

execute "assets precompile" do
  command "cd #{app_dir_current} && RAILS_ENV=#{env} bundle exec rake db:migrate"
end
