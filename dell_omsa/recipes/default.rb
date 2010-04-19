package "snmp"
package "snmpd"
package "openipmi"
package "ipmitool"
package "rpm"

service "dataeng" do
  name "dataeng"
  supports :restart => true, :reload => false
end

service "dsm_om_connsvc" do
  name "dsm_om_connsvc"
  supports :restart => true, :reload => false
end

execute "ldconfig" do
  command "ldconfig"
  action :nothing
  notifies :restart, resources(:service => "dataeng")
  notifies :restart, resources(:service => "dsm_om_connsvc")
end

remote_file "/tmp/dellomsa_5.5.0-5_amd64.deb" do
  source "http://chef.sc-chi-int.37signals.com/dellomsa_5.5.0-5_amd64.deb"
  not_if { File.exists?("/tmp/dellomsa_5.5.0-5_amd64.deb")}
end

dpkg_package "dellomsa_5.5.0-5" do
  source "/tmp/dellomsa_5.5.0-5_amd64.deb"
  notifies :run, resources(:execute => "ldconfig")
end

#fixing webui login issues
remote_file "/lib32/security/pam_nologin.so"  do
  source "pam_nologin.so"
  mode 0755
  owner "root"
  group "root"
  notifies :run, resources(:execute => "ldconfig")
end

remote_file "/lib32/security/pam_unix.so"  do
  source "pam_unix.so"
  mode 0755
  owner "root"
  group "root"
  notifies :run, resources(:execute => "ldconfig")
end