
directory "/root/.ssh" do
  owner "root"
  group "root"
  mode "0700"
end

remote_file "/root/.ssh/id_rsa.storage" do
  source "ssh/id_rsa.storage"
  owner "root"
  group "root"
  mode "0600"
end

