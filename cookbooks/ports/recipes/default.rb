ruby_block "open port 7002" do
  block do
    # fog
    require 'fog'

    # connect to EC2
    connection = Fog::Compute.new({
      :provider => 'AWS',
      :aws_access_key_id => node['aws_secret_id'],
      :aws_secret_access_key => node['aws_secret_key'],
      :region => node['engineyard']['environment']['region']
    })
    
    # find security group
    env_name = node['engineyard']['environment']['name']
    security_group = connection.security_groups.all(:description => env_name).first
    
    # authorize port if not already authorized
    unless security_group.ip_permissions.any?{ |p| p['fromPort'] == 7002 && p['toPort'] == 7002 }
	security_group.authorize_port_range(7002..7002)
    end
  end
  action :create
end
