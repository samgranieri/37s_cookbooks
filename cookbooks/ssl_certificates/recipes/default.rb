directory node[:ssl_certificates][:path] do
  mode "750"
  owner "root"
  group "www-data"
end