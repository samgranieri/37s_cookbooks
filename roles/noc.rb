name "noc"
description "Network opertions server"
recipes "syslog::server", "nagios::server", "apt::mirror", "support"
default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}},
                   :chef => {:validation_token => "372fa8ac3d0f87395f986314897b835a"},
                   :nagios => {:admin_password => "5NDrhTxZpXc.U", :bot_username => '37s.monitoring@gmail.com',
                   :bot_password => 'ig2tya4dral', :bot_authorized_jids => ['jsierles@me.com', 'markimbriaco@mac.com', 'markimbriaco@me.com', 'jsierles@gmail.com']},
                   :cron => {
                     :jobs => {
                       :highrise_misc_rotator => {
                         :command => '/bin/mv /u/logs/highrise/`date +%m%d`/misc.log /u/logs/highrise/`date +%m%d`/misc.log.1',
                         :hour => '12',
                         :minute => '0',
                         :user => 'root'
                      },
                    }
                  }
}
