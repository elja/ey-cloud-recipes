#
# Cookbook Name:: nginx_websocket_conf
# Recipe:: default
#

template "/etc/nginx/servers/Construcs.conf" do
  source "start.conf.erb"
  owner node[:owner_name]
  group node[:owner_name]
  mode 0644
end


execute "reload and start nginx" do
  command "/etc/init.d/nginx reload && /etc/init.d/nginx restart"
end
