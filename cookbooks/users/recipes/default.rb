node[:active_groups].each do |group_name, config|

  users = node[:users].find_all { |u| u.last[:group] == group_name }

  group group_name.to_s do
    Chef::Log.info "Adding group #{group_name}: #{node[:groups]}"
    group = node[:groups][group_name]
    gid group[:gid]
    # TODO: add users to groups under their role
    #members node[:groups]
  end

  users.each do |u, config|
    user u do
      comment config[:comment]
      uid config[:uid]
      gid config[:group].to_s
      home "/home/#{u}"
      shell "/bin/bash"
      password config[:password]
      supports :manage_home => true
    end

    directory "/home/#{u}/.ssh" do
      action :create
      owner u
      group config[:group].to_s
      mode 0700
    end
    
    add_keys u do
      conf config
    end
  end
  
  # remove users who may have been added but are now restricted from this node's role
  # (node[:users] - users).each do |u|
  #   user u do
  #     action :remove
  #   end
  # end
end

# Remove initial setup user and group.
user  "ubuntu" do
  action :remove
end

group "ubuntu" do
  action :remove
end

directory "/u" do
  action :create
  owner "root"
  group "admin"
  mode 0775
end