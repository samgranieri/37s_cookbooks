
package 'libcap2-bin'
package 'bridge-utils'
package 'kvm'
package 'libvirt-bin'
package 'libvirt-dev'
package 'ubuntu-vm-builder'

gem_package 'hpricot'

execute "gem install #{node[:system_root]}/pkg/gems/ruby-libvirt-0.1.0.gem" do
  not_if "gem list ruby-libvirt | grep 0.1.0"
end

execute "give qemu-system-x86_64 net_admin capability" do
  command "/sbin/setcap cap_net_admin=ep /usr/bin/qemu-system-x86_64"
  not_if { `/sbin/getcap /usr/bin/qemu-system-x86_64`.chomp == '/usr/bin/qemu-system-x86_64 = cap_net_admin+ep' }
end

service "networking"
remote_file "/etc/network/interfaces" do
  source "interfaces"
  notifies(:restart, resources(:service => "networking"))  
end
