require_recipe "git"
require_recipe "apache2"

 
directory "/u/git" do
  owner "app"
  group "app"
  mode 0755
end



node[:git][:repos].each do |repo|
  
  directory "/u/git/#{repo}" do
    owner "app"
    group "app"
    mode 0775
  end
  
  execute "initialize new shared git repo" do
    command "cd /u/git/#{repo} && git --bare init --shared"
    only_if { !File.exists? "/u/git/#{repo}/HEAD" }
  end
  
  # install hooks
  
end
