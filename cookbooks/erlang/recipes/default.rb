
package "erlang"

template "/home/app/.erlang.cookie" do
  source "erlang.cookie.erb"
  owner "app"
  group "app"
  mode 0600
end

bash "install erlang libraries" do
  user "root"
  cwd "/usr/lib/erlang/lib/erlang"

  code <<-EOC
  curl http://dist/packages/erlang/mochiweb-02.24.2009.tar.bz2 | tar xfj -
  curl http://dist/packages/erlang/mysql-02.17.2009.tar.bz2 | tar xfj -
  EOC
end
