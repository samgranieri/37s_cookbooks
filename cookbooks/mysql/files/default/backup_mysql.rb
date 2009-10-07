#!/usr/local/bin/ruby

require 'fileutils'

class BackupUtil
  MYSQL_ROOT="/u/mysql"
  BACKUP_ROOT="/u/backup/mysql"

  attr_reader :application, :backup_path, :current_path, :defaults_file
  
  def initialize(application)
    @application = application
    @backup_path = File.join(BACKUP_ROOT, application)
    @current_path = File.join(backup_path, "current")
    @defaults_file = File.join(MYSQL_ROOT, application, "config", "my.cnf")

    unless File.exist?(backup_path)
      STDERR.puts "Usage: #{$0} <application>"
      exit(1)
    end
  end

  def run
    rotate_current
    system("/usr/bin/xtrabackup --defaults-file=#{defaults_file} --target-dir=#{current_path} --backup 2>&1 | tee #{current_path}/backup.log")
  end
  
  def rotate_current
    if stat = File.stat(current_path)
      FileUtils.mv(current_path, get_new_filename(File.join(backup_path, stat.ctime.strftime('%Y%m%d'))))
    end
  rescue Errno::ENOENT
    # no current directory present, not a problem, we'll create it below
  ensure
    FileUtils.mkdir_p(current_path)
  end

  def get_new_filename(path)
    if File.exist?(path)
      (base, suffix) = path.split('.')
      suffix = suffix.to_i
      suffix += 1
      get_new_filename("#{base}.#{suffix}")
    else
      path
    end
  end
end

backup = BackupUtil.new(ARGV[0])
backup.run
