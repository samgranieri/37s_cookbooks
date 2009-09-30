
node[:mysql][:instances].each do |instance|
  mysql_server instance[:name] do
    config instance[:config]
    version instance[:version]
  end
end
