node[:users].each do |u|
  user u[:name] do
    comment u[:comment]
    uid u[:uid]
    gid u[:gid]
    shell "bin/bash"
    password u[:password]
  end
end