#
# Cookbook Name:: imagemagick_installer
# Recipe:: default
#

ey_cloud_report "unmerging default imagemagick" do
  message "unmerging default imagemagick"
end

execute "emerge --unmerge imagemagick" do
  command "emerge --unmerge imagemagick"
  user sudo
end



