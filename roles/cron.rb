name "cron"
description "Cron/utility server"
recipes "cron", "syslog::client", "rails::app_dependencies"
default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
