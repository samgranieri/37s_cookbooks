name "cron"
description "Cron/utility server"
recipes "crontab", "nfs::client", "syslog::client"
default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
