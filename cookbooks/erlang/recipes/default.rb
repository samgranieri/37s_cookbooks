
package "erlang"

template "/home/app/.erlang.cookie" do
  source "erlang.cookie.erb"
  owner "app"
  group "app"
  mode 0600
end

execute "install mysql library" do
  user "root"
  cwd "/usr/lib/erlang/lib"
  command "curl http://dist/packages/erlang/mysql-02.17.2009.tar.bz2 | tar xfj -"
  create "/usr/lib/erlang/lib/mysql-02.17.2009/ebin/mysql.beam"
end

execute "install mochiweb library" do
  user "root"
  cwd "/usr/lib/erlang/lib"
  command "curl http://dist/packages/erlang/mochiweb-02.24.2009.tar.bz2 | tar xfj -"
  create "/usr/lib/erlang/lib/mochiweb-02.24.2009/ebin/mochiweb.beam"
end
