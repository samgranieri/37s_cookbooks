ree_filename = ["ruby-enterprise", node[:ree][:version], node[:ree][:architecture].join("_")

remote_file "/tmp/#{ree_filename}" do
  source 
end

package "ruby-enterprise" do
  source "/tmp/#{ree_filename}"
end