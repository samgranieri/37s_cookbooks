if node[:ec2] && node[:ec2][:userdata]
  ec2_userdata JSON.parse(node[:userdata])
  ec2_userdata.each do |k,v|
    send(k.to_s, v)
  end
end