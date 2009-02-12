ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")] 
set :user, "root"
set :use_sudo, false
role :app, "noc2"
