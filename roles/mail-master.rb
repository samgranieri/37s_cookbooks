name 'mail-master'
description 'Mail master server'

override_attributes :cron => {
    :jobs => {
      :hr_dropbox_worker => {
        :command => '/usr/local/bin/ruby /u/apps/highrise/current/script/dropbox_worker 50',
        :minute => '*/5',
        :user => 'app'
      },
      :hr_email_log_purger => {
        :command => 'find /u/apps/highrise/shared/log/emails/2009/* -maxdepth 1 -type d -mtime +5 -exec rm -rf {} \;',
        :hour => "0",
        :user => 'app',
      },
      :bp_email_worker => {
        :command => '/usr/local/bin/ruby /u/apps/backpack/current/script/email_worker 50',
        :minute => "*/5",
        :user => 'app'
      }
    }
  }
