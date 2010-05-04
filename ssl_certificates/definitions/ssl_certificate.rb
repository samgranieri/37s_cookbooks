define :ssl_certificate do
  
  name = params[:name] =~ /\*\.(.+)/ ? "#{$1}_wildcard" : params[:name]
  
  template "#{node[:ssl_certificates][:path]}/#{name}.crt" do
    source "#{name}.crt"
    mode "0640"
    cookbook "ssl_certificates"
    owner "root"
    group "www-data"
    variables :cert => certs
  end

  template "#{node[:ssl_certificates][:path]}/#{name}.key" do
    source "#{name}.key"
    mode "0640"
    cookbook "ssl_certificates"
    owner "root"
    group "www-data"
  end

  template "#{node[:ssl_certificates][:path]}/#{name}_combined.crt" do
    source "#{name}_combined.crt"
    mode "0640"
    cookbook "ssl_certificates"
    owner "root"
    group "www-data"
  end

end