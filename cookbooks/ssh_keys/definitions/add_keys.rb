define :add_keys do
  
  config = params[:conf]
  name = params[:name]
  keys = Mash.new
  keys[name] = node[:ssh_keys][name]

  if config[:ssh_key_groups]
    config[:ssh_key_groups].each do |group|
      node[:users].find_all{|u| u.last[:group] == group}.each do |user|
        keys[user.first] = node[:ssh_keys][user.first]
      end
    end
  end
  
  if node[:extra_ssh_keys]
    node[:extra_ssh_keys].each do |username|
      keys[username] = node[:ssh_keys][username]
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