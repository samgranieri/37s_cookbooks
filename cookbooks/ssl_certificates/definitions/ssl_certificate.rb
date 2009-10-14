define :ssl_certificate do
  remote_file "#{node[:ssl_certificates][:path]}/#{params[:name]}.crt" do
    source "#{params[:name]}.crt"
    mode "0640"
    cookbook "ssl_certificates"
    owner "root"
    group "www-data"
  end
  remote_file "#{node[:ssl_certificates][:path]}/#{params[:name]}.key" do
    source "#{params[:name]}.key"
    mode "0640"
    cookbook "ssl_certificates"
    owner "root"
    group "www-data"
  end
end