require_recipe "git"
require_recipe "gitosis"
require_recipe "apache2"
 
directory node[:git][:repo_root] do
  owner "git"
  group "git"
  mode 0755
end

directory node[:git][:repo_root]+"/bin" do
  owner "git"
  group "git"
  mode 0755
end

remote_file node[:git][:repo_root]+"/bin/update_mirrors.rb" do
  source "update_mirrors.rb"
  mode 0755
end

if node[:git][:repos]
  node[:git][:repos].each do |repo|
  
    repo_path = "/#{node[:git][:repo_root]}/#{repo}.git"
    
    directory repo_path do
      owner "git"
      group "git"
      mode 0775
    end
  
    execute "initialize new shared git repo" do
      command "cd #{repo_path} && git --bare init --shared"
      only_if { !File.exists? "#{repo_path}/HEAD" }
    end
  
    # install hooks
    
    template "#{repo_path}/hooks/post-receive" do
      source "post-receive-hook.erb"
    end
  end
end