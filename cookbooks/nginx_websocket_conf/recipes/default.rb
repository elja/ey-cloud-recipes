#
# Cookbook Name:: nginx_websocket_conf
# Recipe:: default
#
if ['app_master', 'solo'].include?(node[:instance_role])
	template "/etc/nginx/servers/ConstrucsStage.conf" do
	  source "start.conf.erb"
	  owner node[:owner_name]
	  group node[:owner_name]
	  mode 0644
	end


	execute "reload and start nginx" do
	  command "/etc/init.d/nginx reload && /etc/init.d/nginx restart"
	end
end
