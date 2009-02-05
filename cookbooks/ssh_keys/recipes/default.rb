include_recipe "base"

node[:users].each do |user| 
  if key = node[:ssh_keys].select {|k| k['username'] == user['username']}
    
    directory "/home/#{user['username']}/.ssh" do
      action :create
      owner user['username']
      group user['gid']
      mode 0600
    end
    
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