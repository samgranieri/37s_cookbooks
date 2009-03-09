raise RuntimeError, "The node requires a role, one of: #{node[:roles].keys.join(',')}" unless node[:role] and node[:roles].has_key?(node[:role])

case node[:platform]
when "debian", "ubuntu"
  package "emacs22-nox"
else 
  package "emacs-nox"
end

package "vim"
package "curl"
package "man-db"
package "strace"
package "host"

require_recipe "apt"
require_recipe "git"
require_recipe "postfix"
require_recipe "ssh::server"
include_recipe "ssh_keys"

role[:groups].each do |group_name|

  group group_name.to_s do
    gid node[:groups][group_name][:gid]
  end

  users = node[:users].find_all { |u| u.last[:group] == group_name }

  users.each do |u, config|
    user u do
      comment config[:comment]
      uid config[:uid]
      gid config[:group].to_s
      home "/home/#{u}"
      shell "/bin/bash"
      password config[:password]
      supports :manage_home => true
    end

    directory "/home/#{u}/.ssh" do
      action :create
      owner u
      group config[:group].to_s
      mode 0700
    end
    
    add_keys u do
      conf config
    end
  end
  
  # remove users who may have been added but are now restricted from this node's role
  (node[:users] - users).each do |u|
    user u do
      action :remove
    end
  end
end

directory "/u" do
  action :create
  owner "root"
  group "admin"
  mode 0775
end

directory "/usr/local/build" do
  action :create
  owner "root"
  group "admin"
  mode 0775
end

require_recipe "sudo"
