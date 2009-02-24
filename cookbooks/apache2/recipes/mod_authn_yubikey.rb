package "libcurl3"

remote_file "/usr/lib/apache2/modules/mod_authn_yubikey.so" do
  source "mod_authn_yubikey.so"
end

file "/etc/apache2/conf.d/yubikey_user" do
  action :create
  user "www-data"
  mode 0640
end

file "/etc/apache2/conf.d/yubikey_tmp" do
  action :create
  user "www-data"
  mode 0640
end

template "/etc/apache2/mods-available/authn_yubikey.load" do
  source 'authn_yubikey.load.erb'
end

apache_module "authn_yubikey"