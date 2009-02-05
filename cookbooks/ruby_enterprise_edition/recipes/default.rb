%w(zlib1g-dev libssl-dev libreadline5-dev).each do |p|
  package p
end

filename = @node[:ruby_enterprise_edition][:url].split("/").last
name = filename.split('.tar.gz').first

remote_file "/usr/local/src/#{filename}" do
  source filename
  only_if { @node[:ruby_enterprise_edition][:only_if] }
end

bash "install_ruby_enterprise_edition" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
  tar -zxf #{filename}
  cd #{name}
  ./installer --auto /usr/local
  EOH
  only_if { @node[:ruby_enterprise_edition][:only_if] }
end

