name "cron"
description "Cron/utility server"
recipes "crontab"
default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
