if node[:mysql][:instances]
  node[:mysql][:instances].each do |instance|
    mysql_server instance[:name] do
      config instance[:config]
      version instance[:version]

      if instance[:backup_location]
        backup_location instance[:backup_location]
      end
    end
  end
else
  Chef::Log.warn "You included the MySQL server recipe, but didn't specify MySQL instances"
end