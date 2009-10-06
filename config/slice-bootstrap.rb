
set  :gateway,   "#{ENV['USER']}@gateway.37signals.com"
set  :user,      ENV['BOOTSTRAP_USER'] || "ubuntu"
role :client,    Capistrano::CLI.ui.ask("Host:  ")

set :token,      Proc.new { Capistrano::CLI.ui.ask("Token: ") }
set :bootstrap,  "http://dist/chef/bootstrap.tar"

task :provision do
  sudo "wget -qO - #{bootstrap} | tar xvf - ; cd bootstrap ; ./bootstrap.sh"
end
