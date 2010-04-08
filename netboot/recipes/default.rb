package "dnsmasq"
package "atftp"

service "dnsmasq" do
  name "dnsmasq"
  supports :restart => true, :reload => false
  action :enable
end

directory "/tftpboot" do
  action :create
end

remote_file "/tftpboot/netboot.tar.gz" do
  source "http://archive.ubuntu.com/ubuntu/dists/karmic/main/installer-amd64/current/images/netboot/netboot.tar.gz"
  not_if { File.exists?("/tftpboot/netboot.tar.gz")}
end

execute "extract netboot tar" do
  cwd "/tftpboot"
  command "tar zxf netboot.tar.gz"
end

bash "chown" do
  code "chown -R nobody: /tftpboot"
end

template "dnsmasq.conf" do
  path "/etc/dnsmasq.conf"
  source "dnsmasq.conf.erb"
  owner "root"
  group "root"
  variables(:servers => search(:node, "*:*"))
  mode 0644
  notifies :restart, resources(:service => "dnsmasq")
end

remote_file "/tftpboot/ubuntu-installer/amd64/boot-screens/37menu.cfg"  do
  source "37menu.cfg"
  mode 0755
  owner "nobody"
  group "nogroup"
end

remote_file "/tftpboot/ubuntu-installer/amd64/boot-screens/menu.cfg"  do
  source "menu.cfg"
  mode 0755
  owner "nobody"
  group "nogroup"
end

remote_file "/tftpboot/ubuntu-installer/amd64/boot-screens/splash.png"  do
  source "splash.png"
  mode 0755
  owner "nobody"
  group "nogroup"
end

remote_file "/var/www/nginx-default/client.rb"  do
  source "client.rb"
  mode 0755
  owner "nobody"
  group "nogroup"
end

execute "rm"  do
  command "rm -f /tftpboot/pxelinux.cfg/01-*"
  ignore_failure true
end

execute "rm"  do
  command "rm -f /var/www/nginx-default/01-*.sh"
  ignore_failure true
end

execute "rm"  do
  command "rm -f /var/www/nginx-default/01-*.cfg"
  ignore_failure true
end

execute "symlink" do
  command "ln -s /var/chef/cookbooks/ruby_enterprise_edition/files/default/ruby-enterprise_1.8.7-2010.01_amd64.deb /var/www/nginx-default/ruby-enterprise_1.8.7-2010.01_amd64.deb"
  not_if { File.exists?("/var/www/nginx-default/ruby-enterprise_1.8.7-2010.01_amd64.deb")}
end

search(:node, "*:*") do |server|
  if server[:uptime] == nil
    filename = "01-" + server[:netboot][:mac].downcase.gsub(":", "-")

    template "/var/www/nginx-default/" + filename + ".cfg" do
      path "/var/www/nginx-default/" + filename + ".cfg"
      source "preseed.cfg.erb"
      variables(:key => server.name, :script => filename + ".sh", :server => server[:netboot])
      owner "root"
      group "root"
      mode 0644
    end

    template "/var/www/nginx-default/" + filename + ".sh" do
      path "/var/www/nginx-default/" + filename + ".sh"
      source "post_install_script.sh.erb"
      variables(:key => server.name, :server => server[:netboot], :script => filename + ".sh", :filename => filename)
      owner "root"
      group "root"
      mode 0644
    end

    template filename do
      path "/tftpboot/pxelinux.cfg/" + filename
      source "pxelinux-default.cfg.erb"
      variables(:key => server.name, :filename => filename + ".cfg", :server => server[:netboot], :interface => server[:netboot][:interfaces][:eth0])
      owner "root"
      group "root"
      mode 0644
    end
    
    execute "generate-client.pem"  do
      command "knife client create #{server[:fqdn]} -f /var/www/nginx-default/#{filename}.pem -u chef-validator -k /etc/chef/validation.pem -n -s https://chef/"
      not_if { File.exist?("/var/www/nginx-default/#{filename}.pem") }
    end
  end
end