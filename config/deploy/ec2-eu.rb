ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "europe"), File.join(ENV["HOME"], ".ssh", "id_rsa")] 
set :user, "root"
role :app, "ec2-79-125-53-60.eu-west-1.compute.amazonaws.com"
