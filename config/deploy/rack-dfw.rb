ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")] 
set :user, "root"
set :use_sudo, false
set :gateway, "#{ENV['USER']}@dev.37signals.com"
role :app, "noc2"
