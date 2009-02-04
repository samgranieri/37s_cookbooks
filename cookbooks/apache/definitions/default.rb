define :add_htpasswd_users do
  params[:users].each do |user|
    execute "add_user #{user[0]}" do
      command "/usr/bin/htpasswd -b #{params[:name]} #{user[0]} #{user[1]}"
    end
  end
end