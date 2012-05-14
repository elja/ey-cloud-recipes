#
# Cookbook Name:: imagemagick_installer
# Recipe:: default
#
if ['app_master', 'solo'].include?(node[:instance_role])
	image_magick_path="/home/deploy/ImageMagick-6.7.3-9"

	ey_cloud_report "unmerging default imagemagick" do
	  message "unmerging default imagemagick"
	end

	execute "emerge --unmerge imagemagick" do
	 command "emerge --unmerge imagemagick"
	end


	ey_cloud_report "installing new imagemagick" do
	 message "installing new imagemagick"
	end

	execute "configurate image magick" do
	  command "cd #{image_magick_path} && make distclean && ./configure --prefix='/usr/' && make && make install"
	end
end



