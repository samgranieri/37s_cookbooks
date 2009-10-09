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
  owner "root"
  group "admin"
  mode 0755
end

directory "/u/system/bin" do
  owner "root"
  group "admin"
  mode 0755  
end

remote_file "/usr/local/bin/memory_stats" do
  source "memory_stats"
  mode 0755
end

remote_file "/usr/local/bin/rotate-email-folders" do
  source "rotate-email-folders"
  mode 0755
end

remote_file "/usr/local/bin/rotate-misc-log" do
  source "rotate-misc-log"
  mode 0755
end
