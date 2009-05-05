
set  :gateway,   "#{ENV['USER']}@dev.37signals.com"
set  :user,      ENV['BOOTSTRAP_USER'] || "ubuntu"
role :client,    Capistrano::CLI.ui.ask("Host:  ")

set :token,      Proc.new { Capistrano::CLI.ui.ask("Token: ") }
set :dist,       "http://dist/"
set :debs,       "#{dist}debs/intrepid/ruby"
set :ruby_pkg,   "ruby-enterprise_1.8.6-20090201_amd64.deb"
set :chef_reqs,  "#{dist}/chef/bootstrap"
set :client_cfg, "#{chef_reqs}/client.rb"
set :slice_json, "#{chef_reqs}/slice.json"
set :chef_gem,   "#{chef_reqs}/chef.gem"
set :ohai_gem,   "#{chef_reqs}/ohai.gem"

task :provision do
  run "wget -qO /tmp/#{ruby_pkg} #{debs}/#{ruby_pkg}"
  sudo "dpkg -i /tmp/#{ruby_pkg}"
  sudo "mkdir -p /etc/chef"
  sudo "wget -qO /etc/chef/client.rb #{client_cfg}"
  run "wget -qO /tmp/chef.gem #{chef_gem}"
  run "wget -qO /tmp/ohai.gem #{ohai_gem}"
  sudo "gem install /tmp/ohai.gem /tmp/chef.gem"
  sudo "wget -qO /etc/chef/node.json #{slice_json}"
  sudo "mkdir -p /var/log/chef"
  sudo "chef-client -j /etc/chef/node.json -t #{token}"
end
