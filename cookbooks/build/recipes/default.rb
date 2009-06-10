case node[:platform]
when "ubuntu","debian"
  %w{build-essential binutils-doc}.each do |pkg|
    package pkg do
      action :install
    end
  end
when "centos"
  package "gcc" do
    action :install
  end
end

package "autoconf" do
  action :install
end

package "flex" do
  action :install
end

package "bison" do
  action :install
end

gem_package "git_remote_branch"

if node[:build]
  node[:build].each do |name, config|
    config[:packages].each do |pack|
      package pack
    end
  end
end