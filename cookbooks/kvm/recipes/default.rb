#
# Cookbook Name:: kvm
# Recipe:: default
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#

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

directory "/u/kvm/tmp"
directory "/u/kvm/images"

remote_directory "/usr/local/share/kvm" do
  source "templates"
  files_backup 2
  files_owner "root"
  files_group "admin"
  files_mode 0640
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
    if kvm_modules.include?(File.basename(old_module))
      FileUtils.mv(old_module, "#{old_module}.orig")
      updated_modules = true
    end
  end
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
