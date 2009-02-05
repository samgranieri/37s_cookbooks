# BROKEN
# node[:groups].each do |g|
#   group g[:name] do
#     gid g[:gid]
#   end
# end

# node[:users].each do |u|
#   user u[:username] do
#     comment u[:comment]
#     uid u[:uid]
#     gid u[:gid]
#     shell "/bin/bash"
#     password u[:password]
#   end
# end

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