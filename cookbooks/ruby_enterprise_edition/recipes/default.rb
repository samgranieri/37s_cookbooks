remote_file "/tmp/#{node[:ree][:package_name]}" do
  source node[:ree][:package_name]
end

package "ruby-enterprise" do
  source "/tmp/#{node[:ree][:package_name]}"
end