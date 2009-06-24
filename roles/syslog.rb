name "syslog"
description "syslog server"
recipes "syslog::server"
default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}