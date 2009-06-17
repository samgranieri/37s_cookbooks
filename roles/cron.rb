name "cron"
description "Cron/utility server"
recipes "crontab"
default_attributes :active_groups => {:dev => {:enabled => true}},
                   :active_sudo_groups => {:dev => {:enabled => true}}
