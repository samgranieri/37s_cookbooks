
directory "/u/backup" do
  recursive true
  owner "storage"
  group "storage"
  mode "0775"
end

node[:backup][:devices].each_key do |mount_point|
  mount "/u/backup/#{mount_point}" do
    device node[:backup][:devices][mount_point][:device]
    fstype "ext3"
    action [ :enable, :mount ]
  end
end
