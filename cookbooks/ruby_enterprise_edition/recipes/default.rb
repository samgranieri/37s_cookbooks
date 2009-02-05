%w(zlib1g-dev libssl-dev libreadline5-dev).each do |p|
  package p
end

url = @node[:ruby_enterprise_edition][:url]
tarball = url.split('/').last
name = tarball.split('.tar.gz').first

remote_file "/usr/local/src/#{tarball}" do
  source url
  only_if @node[:ruby_enterprise_edition][:only_if]
end

bash "install_ruby_enterprise_edition" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
  tar -zxf #{tarball}
  cd #{name}
  ./installer --auto /usr/local
  EOH

  only_if @node[:ruby_enterprise_edition][:only_if]
end

