name "noc"
description "Network opertions server"
recipes "syslog::server", "nagios::server", "syslog::server", "apt::mirror"
default_attributes :active_groups => {:dev => {:enabled => true}},
                   :active_sudo_groups => {:dev => {:enabled => true}}
