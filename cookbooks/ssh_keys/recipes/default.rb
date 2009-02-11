require_recipe "base"

node[:users].each do |name, config| 
    
  keys = {}
  keys[name] = node[:ssh_keys][name]
  
  if config[:ssh_key_groups]
    config[:ssh_key_groups].each do |group|
      node[:groups][group][:members].each do |user|
        keys[user] = node[:ssh_keys][user]
      end
    end
  end
  
  template "/home/#{name}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    action :create
    owner name
    group config[:group].to_s
    variables(:keys => keys)
    mode 0600
  end

end