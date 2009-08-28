case node[:platform]
when "debian", "ubuntu"
  package "policykit"
  package "emacs22-nox"
  require_recipe "apt"
else 
  package "emacs-nox"
end

package "vim"
package "curl"
package "man-db"
package "strace"
package "host"
package "lsof"
package "gdb"
package "socat"
package "procmail"
package "zsh"
package "ack"

directory "/u/system" do
  owner "app"
  group "app"
  mode 0755
end

directory "/u/system/bin" do
  owner "app"
  group "app"
  mode 0755  
end

remote_file "/usr/local/bin/rotate-email-folders" do
  source "rotate-email-folders"
  mode 0755
end