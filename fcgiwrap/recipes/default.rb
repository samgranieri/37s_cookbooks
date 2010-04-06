package "libfcgi-dev"

remote_file "/tmp/fcgiwrap.tar.gz" do
  not_if { File.exists?("/usr/local/sbin/fcgiwrap") }
end

execute "unpack fcgiwrap" do
  cwd "/tmp"
  command "tar xvzf /tmp/fcgiwrap.tar.gz"
  only_if { File.exists?("/tmp/fcgiwrap.tar.gz")}
end

execute "make and install fcgiwrap" do
  command "autoconf && configure && make && make install"
  creates "/usr/local/sbin/fcgiwrap"
end