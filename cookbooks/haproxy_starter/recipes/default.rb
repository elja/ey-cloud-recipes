#
# Cookbook Name:: haproxy_starter
# Recipe:: default
#
haproxy_path="/home/deploy/haproxy-1.4.19"
haproxy_cfg_path="/home/deploy/haproxy.cfg"

ey_cloud_report "starting HAProxy" do
  message "starting HAProxy"
end


execute "haproxy start" do
  command "#{haproxy_path}/haproxy -f #{haproxy_cfg_path}"
end

