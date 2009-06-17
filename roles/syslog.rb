name "syslog"
description "syslog server"
recipes "syslog::server"
default_attributes :active_groups => {:dev => {:enabled => true}},
                   :active_sudo_groups => {:dev => {:enabled => true}}