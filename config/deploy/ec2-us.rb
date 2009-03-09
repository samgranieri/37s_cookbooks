ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "ec2"), File.join(ENV["HOME"], ".ssh", "id_rsa")] 
set :user, ENV["USER"]
role :app, "noc.ec2-us.37signals.com"

require 'erb'
require 'right_aws'

ROLE_IMAGE_MAP = {:app => {:ami => "ami-7cfd1a15", :type => 'c1.medium'},
                  :noc => {:ami => "ami-7cfd1a15", :type => 'c1.medium'}
}

namespace :ec2 do
  desc "Launch an instance and bootstrap it for chef"
  task :launch do
    raise(ArgumentError, "Please set HOSTNAME, ROLE, AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY") unless ENV['HOSTNAME'] && ENV['ROLE'] && ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY']
    @hostname = ENV['HOSTNAME']
    @domain = "ec2-us-int.37signals.com"
    public_domain = "ec2-us.37signals.com"
    @public_fqdn = ENV['PUBLIC_FQDN'] || "#{@hostname}.#{public_domain}"
    @role = ENV['ROLE']
    @primary_nameserver_ip = "10.253.130.160"
    @validation_token = "372fa8ac3d0f87395f986314897b835a"
    
    config = ROLE_IMAGE_MAP[@role.to_sym]
    output = ERB.new(File.read(File.dirname(__FILE__)+"/../bootstrap.erb")).result(binding)
    
    ec2 = RightAws::Ec2.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    result = ec2.launch_instances(config[:ami], :group_ids => ['default', @role], :instance_type => config[:type], :key_name => 'ec2', :user_data => output)
    puts result.inspect
  end
end