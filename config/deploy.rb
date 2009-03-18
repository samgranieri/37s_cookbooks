set :application, "chef_recipes"
set :scm_user, ENV['USER']
set :repository, "ssh://#{scm_user}@dev.37signals.com/u/git/chef_recipes.git"
set :deploy_to, "/var/chef_recipes"
set :scm, :git

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

require 'capistrano/ext/multistage'

desc "Install essential packages for chef"
task :bootstrap do
  run "apt-get update"
  run "DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get -qyu install emacs22-nox vim git-core mysql-client libshadow-ruby1.8 libmysqlclient15-dev build-essential syslog-ng ntp ruby ruby1.8-dev rubygems libopenssl-ruby1.8 irb rdoc ri rubygems man-db rake curl"
  install_rubygems
  run "mkdir -p /etc/chef /var/chef /var/chef/merb/log /var/chef/openid/cstore && chown -R www-data /var/chef/openid /var/chef/merb"
  run "sudo gem sources -a http://gems.opscode.com && gem sources -a http://gems.github.com"
  install_chef
  
end

desc "Install rubygems"
task :install_rubygems do
  run "cd /tmp && wget http://rubyforge.org/frs/download.php/45904/rubygems-update-1.3.1.gem && sudo gem install rubygems-update-1.3.1.gem && sudo /var/lib/gems/1.8/bin/update_rubygems"
end

desc "Install latest chef"
task :install_chef do
  run "gem install rspec json --no-rdoc --no-ri"
  run "git clone git://github.com/opscode/ohai.git"
  run "cd ohai && rake install"
  run "git clone git://github.com/opscode/chef.git"
  run "cd chef && rake install"
end

desc "Update chef"
task :update_chef do
  run "cd ~/chef && git pull && rake install"
  run "cd ~/ohai && git pull && rake install"
end

desc "Update recipes"
task :update_recipes do
  run "cd #{deploy_to} && rake install"
end

desc "Create tarball for chef solo"
task :create_tarball do
  run "cd /var/chef && tar czvf /u/sites/dist/cookbooks.tgz cookbooks"
end

desc "Run chef solo"
task :run_solo do
  run "cd #{deploy_to} && chef-solo -c config/solo.rb -j config/#{stage}/backup.json"
end

after "deploy", "update_recipes"
after "update_recipes", "create_tarball"
deploy.task :default, :except => {:no_release => true} do
  run "cd #{deploy_to} && git config remote.origin.url #{repository} && git pull"
end
