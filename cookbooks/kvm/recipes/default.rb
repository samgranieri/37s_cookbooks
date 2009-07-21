# custom vmbuilder debs
%W(kvm debootstrap kpartx python-cheetah devscripts python-libvirt).each { |pkg| package pkg }
%W(python-vm-builder_0.9-0ubuntu6_all.deb
   ubuntu-vm-builder_0.9-0ubuntu6_all.deb).each do |pkg|
  remote_file "/tmp/#{pkg}" do
    source "http://dist/debs/intrepid/vmbuilder/#{pkg}"
    not_if "test -e /usr/bin/#{pkg.split('_').first.sub('python-vm-', 'vm')}"
  end

  package pkg do
    provider Chef::Provider::Package::Dpkg
    source "/tmp/#{pkg}"
    only_if "test -e /tmp/#{pkg}"
  end

  execute "remove_deb" do
    command "rm -f /tmp/#{pkg}"
    only_if "test -e /tmp/#{pkg}"
  end
end

%W(tmp images).each do |dir|
  directory "/u/kvm/#{dir}" do
    recursive true
  end
end

remote_directory "/usr/local/share/kvm" do
  source "templates"
  files_backup 2
  files_owner "root"
  files_group "admin"
  files_mode 0755
  owner "root"
  group "admin"
  mode 0750
end

remote_directory "/lib/modules/#{@node[:kernel][:release]}/extra" do
  source "modules/#{@node[:kernel][:release]}"
  files_backup 0
  files_owner "root"
  files_group "root"
  files_mode 0644
  owner "root"
  group "root"
  mode 0755
  ignore_failure true
end

kvm_modules = Dir.glob("/lib/modules/#{@node[:kernel][:release]}/extra/kvm*.ko").map { |f| File.basename(f) }
%W(drivers/kvm arch/x86/kvm).each do |module_dir|
  Dir.glob("/lib/modules/#{@node[:kernel][:release]}/kernel/#{module_dir}/*.ko").each do |old_module|
    execute "backup old kvm module: #{old_module}" do
      command "mv #{old_module} #{old_module}.orig"
      only_if { kvm_modules.include?(File.basename(old_module)) && File.exist?(old_module) }
    end
  end
end

bash "update kvm userspace" do
  user "root"
  cwd "/tmp"

  code <<-EOH
  curl http://dist/misc/kvm-84.tar.bz2 | tar -C /usr/local -xjf -
  mkdir /usr/bin/kvm-dist
  mv /usr/bin/kvm* /usr/bin/kvm-dist/.
  ln -sf /usr/local/kvm/bin/qemu-system-x86_64 /usr/bin/kvm
  ln -sf /usr/local/kvm/bin/qemu-img /usr/bin/kvm-img
  ln -sf /usr/local/kvm/bin/qemu-nbd /usr/bin/kvm-nbd
  EOH
  
  not_if { File.directory?("/usr/local/kvm") }
end

execute "modprobe" do
  command "/sbin/depmod -a"
  action :run
  
  only_if do
    File.exist?("/lib/modules/#{@node[:kernel][:release]}/extra/kvm.ko") &&
      ( File.mtime("/lib/modules/#{@node[:kernel][:release]}/extra/kvm.ko") >
        File.mtime("/lib/modules/#{@node[:kernel][:release]}/modules.dep") )
  end
end

gem_package "thor"

remote_file "/usr/local/bin/kvmtool" do
  source "kvmtool"
  mode 0755
end

service "libvirt-bin" do
  supports :restart => false, :reload => true
  action :enable
end

template "/etc/libvirt/libvirtd.conf" do
  source "libvirtd.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :reload, resources(:service => "libvirt-bin")
end
