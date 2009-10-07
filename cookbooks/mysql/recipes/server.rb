
package "xtrabackup"

if node[:mysql] && node[:mysql][:instances]
  script_dir = File.join(node[:mysql][:root], "scripts").to_s

  directory script_dir do
    owner "root"
    group "root"
    mode 0700
  end

  remote_file File.join(script_dir, "backup_mysql.rb") do
    source "backup_mysql.rb"
    owner "root"
    group "root"
    mode "0700"
  end

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
