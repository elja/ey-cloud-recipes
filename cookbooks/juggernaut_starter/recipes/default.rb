#
# Cookbook Name:: juggernaut_starter
# Recipe:: default
#

# npm install -g juggernaut
# gem install juggernaut

node_js_path="/home/deploy/node-v0.6.6"

ey_cloud_report "installing node.js" do
  message "installing node.js"
end

execute "node.js install" do
  command "cd #{node_js_path} && ./configure && make && make install"
end

ey_cloud_report "installing juggernaut npm" do
  message "installing juggernaut npm"
end

execute "npm install -g juggernaut" do
   command "npm install -g juggernaut"
end  

ey_cloud_report "installing juggernaut gem" do
  message "installing juggernaut gem"
end

execute "gem install juggernaute" do
  command "gem install juggernaut"
end 


ey_cloud_report "starting juggernaut" do
  message "starting juggernaut"
end


execute "juggernaut start" do
  command "nohup juggernaut --port 8000 > jugger.out 2> jugger.err < /dev/null &"
end
