#
# Cookbook Name:: nginx_websocket_conf
# Recipe:: default
#
app_name="Construcs"
server_name="beta.construcs.com"
server_port="8090"
env = "beta"
juggernaut_port="8000"

template "/etc/nginx/servers/#{app_name}.conf" do
  source "start.conf.erb"
  owner node[:owner_name]
  group node[:owner_name]
  mode 0644
  variables({
    :app_name => app_name,
    :env => env,
    :juggernaut_port => juggernaut_port,
    :server_name => server_name,
    :server_port => server_port
  })
end


execute "reload and start nginx" do
  command "/etc/init.d/nginx reload && /etc/init.d/nginx restart"
end
