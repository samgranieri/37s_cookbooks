
package "erlang"

template "/home/app/.erlang.cookie" do
  source "erlang.cookie.erb"
  owner "app"
  group "app"
  mode 0600
end
