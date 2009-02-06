node[:groups].each do |name, config|
  group name do
    gid config[:gid]
  end
end

node[:users].each do |name, config|
  user name do
    comment config[:comment]
    uid config[:uid]
    gid config[:gid]
    home "/home/#{name}"
    shell "/bin/bash"
    password config[:password]
  end
end

directory "/home/#{name}/.ssh" do
  action :create
  owner name
  group config[:gid]
  mode 0700
end

directory "/u/app" do
  action :create
  owner "app"
  group "app"
  mode 0775
end

directory "/u/site" do
  action :create
  owner "site"
  group "site"
  mode 0775
end