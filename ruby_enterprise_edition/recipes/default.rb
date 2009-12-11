ree_filename = ["ruby-enterprise", node[:ree][:version], node[:ree][:architecture]].join("_")+".deb"

remote_file "/tmp/#{ree_filename}" do
  source ree_filename
end

dpkg_package "ruby-enterprise" do
  source "/tmp/#{ree_filename}"
end