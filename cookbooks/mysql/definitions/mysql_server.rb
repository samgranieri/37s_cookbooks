define :mysql_server, :options => {} do
  base_dir = "#{node[:mysql][:root]}/#{params[:name]}"
  params[:config] ||= {}
  directories = [ base_dir ]
  
  %W(binlogs config data logs).each do |d|
    directories << "#{base_dir}/#{d}"
  end

  group "mysql" do
    gid node[:mysql][:gid]
  end

  user "mysql" do
    uid node[:mysql][:uid]
    gid node[:mysql][:gid]
    comment "MySQL Server"
    home "/u/mysql"
  end

  directories.each do |dir|
    directory dir do
      owner "mysql"
      group "mysql"
      mode 0755
      recursive true
      action :create
    end
  end

  execute "install mysql binaries" do
    user "root"
    group "root"
    cwd "/tmp"
    command "curl http://dist/packages/mysql/mysql-#{params[:version]}.tar.bz2 | tar -xjC #{node[:mysql][:root]}/server -f -"
    creates "#{node[:mysql][:root]}/server/#{params[:version]}"
  end
  
  defaults = Mash.new({
    :datadir => "#{node[:mysql][:root]}/#{params[:name]}/data",
    :log_root => "#{node[:mysql][:root]}/#{params[:name]}/logs",
    :mysqld_error_log => "#{node[:mysql][:root]}/#{params[:name]}/logs/mysql.err",
    :socket_path => "/tmp/mysql.#{params[:name]}.sock",
    :slow_query_log => "#{node[:mysql][:root]}/#{params[:name]}/logs/mysql_slow_queries.log",
    :error_log => "#{node[:mysql][:root]}/#{params[:name]}/logs/mysql.log.err",
    :binlog_dir => "#{node[:mysql][:root]}/#{params[:name]}/binlogs/binlog",
    :innodb_log_dir => "#{node[:mysql][:root]}/#{params[:name]}/binlogs",
    :pidfile => "#{node[:mysql][:root]}/#{params[:name]}/logs/mysql.pid",
    :server_id => "1",
    :binlogs_enabled => false,
    :port => "3306",
    :innodb_file_per_table => true,
    :innodb_buffer_pool_size => "500M",
    :percona_patches => false                        
  })

  params[:config] = defaults.merge(params[:config])
  
  template "#{base_dir}/config/my.cnf" do
    source "mysql.cnf.erb"
    owner "mysql"
    group "mysql"
    mode 0644
    variables(:config => params[:config])
  end

  execute "install empty database" do
    user "mysql"
    group "mysql"
    cwd "/tmp"
    command "#{node[:mysql][:root]}/server/#{params[:version]}/bin/mysql_install_db --defaults-file=#{base_dir}/config/my.cnf --user=mysql"
    action :run
  end
  
  template "/etc/init.d/mysql_#{params[:name]}" do
    source "init.sh.erb"
    owner "root"
    group "root"
    mode 0700
    variables(:options => params, :node => node)
  end

  service "mysql_#{params[:name]}" do
    action [ :enable, :start ] 
  end

  if params[:backup_location]
    package "xtrabackup"
  end
end
