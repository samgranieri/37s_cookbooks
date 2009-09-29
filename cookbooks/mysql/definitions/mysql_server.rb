define :mysql_service, :options => {} do
  base_dir = "#{node[:mysql][:root]}/#{params[:name]}"
  directories = [ base_dir ]
  
  %W(binlogs config data logs).each do |d|
    directories << "#{base_dir}/#{d}"
  end

  directories.each do |dir|
    directory dir do
      owner "mysql"
      group "mysql"
      mode 0755
    end
  end

  defaults = {
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
    :innodb_buffer_pool_size => "500M"
  }
  
  template "#{base_dir}/config/my.cnf" do
    source "my.cnf.erb"
    owner "mysql"
    group "mysql"
    mode 0644
  end

  bash "install mysql binaries" do
    command "curl http://dist/packages/mysql/mysql-#{params[:version]}.tar.bz2 | tar xfC #{node[:mysql][:root]}/server"
    not_if File.exist?("#{node[:mysql][:root]}/server/#{params[:version]}")
  end
end
