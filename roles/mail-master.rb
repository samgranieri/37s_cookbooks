name 'mail-master'
description 'Mail master server'

override_attributes :cron => {
    :jobs => {
      :hr_dropbox_worker => {
        :command => '/usr/local/bin/ruby /u/apps/highrise/current/script/dropbox_worker 50 > /dev/null',
        :minute => '*/5',
        :user => 'app'
      },
      :bp_email_worker => {
        :command => '/usr/local/bin/ruby /u/apps/backpack/current/script/email_worker 50 > /dev/null',
        :minute => "*/5",
        :user => 'app'
      }
    }
  }