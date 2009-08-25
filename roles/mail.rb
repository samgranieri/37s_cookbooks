name 'mail'
description 'Mail server'
recipes 'postfix::virtual', 'postfix::aliases', 'cron', 'rails::app_dependencies', 'syslog::client', 'nfs::client'

override_attributes :active_groups => {:app => {:enabled => true}},
                    :active_sudo_groups => {:app => {:enabled => true}},
                    :active_sudo_users => [
                      {:user => "nobody", :target_user => "app", :command => "NOPASSWD:/u/apps/backpack/current/script/email_helper"},
                      {:user => "nobody", :target_user => "app", :command => "NOPASSWD:/u/apps/basecamp/current/script/email_helper"},
                      {:user => "nobody", :target_user => "app", :command => "NOPASSWD:/u/apps/highrise/current/script/email_helper"},
                      {:user => "nobody", :target_user => "app", :command => "NOPASSWD:/u/apps/highrise/current/script/dropbox_helper"}
                    ],
  :nfs_mounts => {
    "/u/nfs/file1/depot"  =>  {"device" => "172.28.1.66:/u/depot",  "owner"  => "app"},
    "/u/nfs/file2/depot"  =>  {"device" => "172.28.1.67:/u/depot",  "owner"  => "app"},
    "/u/nfs/file3/depot"  =>  {"device" => "172.28.1.70:/u/depot",  "owner"  => "app"}
  },
  :cron => {
    :jobs => {
      :bc_email_replies => {
        :command => '/usr/local/bin/ruby /u/apps/basecamp/current/script/email_replies/process_incoming 150',
        :minute => '*/5',
        :user => 'app'
      },
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
      },
      :email_rotation => {
        :command => '/usr/local/bin/rotate-email-folders basecamp,highrise,backpack',
        :minute => "0",
        :hour => "3",
        :user => 'app'
      },
      :email_rotation_cleanup => {
        :command => 'find /u/apps/*/shared/email/old -maxdepth 1 -mtime +7 -exec rm -rf {} \;',
        :minute => "0",
        :hour => "4",
        :user => 'app'
      }
    }
  },
  
  :postfix => {
    :virtual_domains => {
      '/^virt-gw\.37signals\.com$/' => 'VIRTUAL',
      '/^app@virt-gw\.37signals\.com$/' => 'devnull@localhost',

      '/^([^@]+\.)?(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/' => 'VIRTUAL',
      '/^P\d+-reply@(([^@])+\.)basecamphq\.com$/' => 'basecamp@localhost',
      '/^((basecamp)|([Uu]\d+[PpIiMm]\d+-reply))@([^\.]+\.)(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/' => 'basecamp@localhost',
      '/^do-not-reply(.+)?@([^\.]+\.)*(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/' => 'devnull',
      '/^notifications@basecamphq\.com$/' => 'devnull',
      '/^postmaster@(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/' => 'postmaster@37signals.com',
      '/^support@(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/' => '37signals.support@gmail.com',
      '/^transition@basecamphq\.com$/' => 'jason@37signals.com',    
      '/^requests@basecamphq\.com$/' => '37signals.support@gmail.com',
      '/^errors?@basecamphq\.com$/' => '37signals.support@gmail.com',
    
      '/^campfirenow\.com$/'            => 'VIRTUAL',
      '/^postmaster@campfirenow\.com$/' => 'postmaster@37signals.com',
      '/^support@campfirenow\.com$/'    => '37signals.support@gmail.com',
    
      '/^tadalist\.com$/'             => 'VIRTUAL',
      '/^postmaster@tadalist\.com$/'  => 'postmaster@37signals.com',
      '/^support@tadalist\.com$/'     => '37signals.support@gmail.com',
      '/^tadalists\.com$/'            => 'VIRTUAL',
      '/^postmaster@tadalists\.com$/' => 'postmaster@37signals.com',
      '/^support@tadalists\.com$/'    => 'jason',
    
      '/^([^@]+\.)?backpackit\.com$/' => 'VIRTUAL',
      '/@([^@]+\.)backpackit\.com$/'  => 'backpack@localhost',
      '/^share@backpackit\.com$/'     => '37signals.support@gmail.com',
      '/^support@backpackit\.com$/'   => '37signals.support@gmail.com',
      '/^system@backpackit\.com$/'    => '37signals.support@gmail.com',
      '/^alert@backpackit\.com$/'     => 'devnull',
      '/^([^@]+\.)?highrisehq\.com$/' => 'VIRTUAL',
      '/^(forum\.)?highrisehq\.com$/' => 'VIRTUAL',
      '/^dropbox(\+.+)?@(\d+)\.([^\.]+)\.highrisehq\.com$/' => 'highrise@localhost',
      '/^case\+dropbox@(\d+)\.([^\.]+)\.highrisehq\.com$/'  => 'highrise@localhost',
      '/^deal\+dropbox@(\d+)\.([^\.]+)\.highrisehq\.com$/'  => 'highrise@localhost',
      '/^task(\+.+)?@(\d+)\.([^\.]+)\.highrisehq\.com$/'    => 'highrise@localhost',
      '/^postmaster@highrisehq\.com$/'                      => 'postmaster@37signals.com',
      '/^cancel@highrisehq\.com$/'                          => '37signals.support@gmail.com',
      '/^hr-cron@37signals\.com$/'                          => 'hr-exceptions@37signals.com',
      '/^solr-cron@37signals\.com$/'                        => 'solr@37signals.com',
      '/^support@highrisehq\.com$/'                         => '37signals.support@gmail.com',
      '/^bounces@highrisehq\.com$/'                         => 'devnull',
      '/^system@highrisehq\.com$/'                          => 'devnull',
      '/@forum\.highrisehq\.com$/'                          => 'devnull',
    
      '/^writeboard\.com$/' => 'VIRTUAL',
      '/^postmaster@writeboard\.com$/' => 'postmaster@37signals.com',
      '/^support@writeboard\.com$/' => '37signals.support@gmail.com',
      '/^system@writeboard\.com$/' => 'wb-system'
    },
    :aliases => {
      'basecamp'  => '|/usr/bin/sudo -u app /u/apps/basecamp/current/script/email_helper',
      'backpack'  => '|/usr/bin/sudo -u app /u/apps/backpack/current/script/email_helper',
      'highrise'  => '|/usr/bin/sudo -u app /u/apps/highrise/current/script/email_helper'
    }
  }
