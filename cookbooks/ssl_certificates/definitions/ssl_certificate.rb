define :ssl_certificate, :wildcard => false do
  
  name = params[:wildcard] ? "#{params[:name]}_wildcard" : params[:name]
  
  remote_file "#{node[:ssl_certificates][:path]}/#{name}.crt" do
    source "#{name}.crt"
    mode "0640"
    cookbook "ssl_certificates"
    owner "root"
    group "www-data"
  end
  remote_file "#{node[:ssl_certificates][:path]}/#{name}.key" do
    source "#{name}.key"
    mode "0640"
    cookbook "ssl_certificates"
    owner "root"
    group "www-data"
  end
  remote_file "#{node[:ssl_certificates][:path]}/#{name}_intermediate.crt" do
    source "#{name}_intermediate.crt"
    mode "0640"
    cookbook "ssl_certificates"
    owner "root"
    group "www-data"
  end
end