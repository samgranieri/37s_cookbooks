define :aws_credentials do
  remote_file "#{node[:aws][:path]}/#{params[:name]}.yml" do
    source "#{params[:name]}.yml"
    mode "0640"
    cookbook "aws"
    owner "root"
    group "app"
  end
end