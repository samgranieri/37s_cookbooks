node[:groups].each do |u, config|
  group u do
    gid config[:gid]
  end
end

node[:users].each do |u, config|
  user u do
    comment config[:comment]
    uid config[:uid]
    gid config[:gid]
    home "/home/#{u}"
    shell "/bin/bash"
    password config[:password]
  end
end

directory "/home/#{u}/.ssh" do
  action :create
  owner u
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