include_recipe "base"

node[:users].each do |name, config| 
  
  directory "/home/#{name}/.ssh" do
    action :create
    owner name
    group config['gid']
    mode 0700
  end
  
  if key = node[:ssh_keys][user]      
    template "/home/#{user['username']}/.ssh/authorized_keys" do
      source "authorized_keys.erb"
      action :create
      owner user['username']
      group user['gid']
      variables(:keys => [key])
      mode 0600
    end
  end

end