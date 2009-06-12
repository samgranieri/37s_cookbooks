name "noc"
description "Network opertions server"
recipes "chef::client", "syslog::server", "nagios::server"
default_attributes :active_groups => {:dev => {:enabled => true}},
                   :active_sudo_groups => {:dev => {:enabled => true}}
