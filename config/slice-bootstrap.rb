
set  :gateway,   "#{ENV['USER']}@dev.37signals.com"
set  :user,      ENV['BOOTSTRAP_USER'] || "ubuntu"
role :client,    Capistrano::CLI.ui.ask("Host:  ")

set :token,      Proc.new { Capistrano::CLI.ui.ask("Token: ") }
set :dist,       "http://dist/"
set :debs,       "#{dist}debs/intrepid/ruby"
set :ruby_pkg,   "ruby-enterprise_1.8.6-20090610_amd64.deb"
set :chef_reqs,  "#{dist}/chef/bootstrap"
set :client_cfg, "#{chef_reqs}/client.rb"
set :slice_json, "#{chef_reqs}/slice.json"
set :chef_gem,   "#{chef_reqs}/chef-0.7.10.gem"
set :ohai_gem,   "#{chef_reqs}/ohai-0.3.2.gem"

task :provision do
  sudo "wget -qO - http://dist/chef/bootstrap.tar | tar xvf - ; cd bootstrap ; ./bootstrap.sh"
end
