ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "ec2"), File.join(ENV["HOME"], ".ssh", "id_rsa")] 
set :user, ENV["USER"]
role :app, "noc.ec2-us.37signals.com"