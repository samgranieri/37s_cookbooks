ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "europe"), File.join(ENV["HOME"], ".ssh", "id_rsa")] 
set :user, "root"
role :app, "ec2-79-125-52-6.eu-west-1.compute.amazonaws.com"

set :ec2_run, "ec2-run-instances ami-aa032bde -f bin/ec2_bootstrap.sh -k europe -t c1.medium"