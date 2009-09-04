package "nfs-kernel-server"

remote_file "/home/storage/.ssh/id_rsa" do
  source "ssh/id_rsa.storage"
  owner "storage"
  group "storage"
  mode "0600"
end

directory "/u/backup" do
  recursive true
  owner "storage"
  group "storage"
  mode 0775
end

node[:backup][:devices].each_key do |mount_point|
  directory "/u/backup/#{mount_point}" do
    owner "storage"
    group "storage"
    mode 0775
  end
  
  mount "/u/backup/#{mount_point}" do
    device node[:backup][:devices][mount_point][:device]
    fstype "ext3"
    action [ :enable, :mount ]
  end
end
