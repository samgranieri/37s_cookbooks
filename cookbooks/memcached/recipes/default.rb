package "memcached"

%w(libevent1_1.4.9-1ubuntu1_amd64.deb memcached_1.2.6-1ubuntu2_amd64.deb).each do |f|
  remote_file "/tmp/#{f}" do
    source f
  end
  execute "install #{f}" do
    command "dpkg -i /tmp/#{f}"
    package, version, arch = f.split("_")
    not_if "dpkg -l | grep #{package} | grep #{version} | grep ii"
  end
end

directory "/etc/memcached"