name "noc"
description "Network opertions server"
recipes "syslog::server", "nagios::server", "apt::mirror"
default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}},
                   :chef => {:validation_token => "372fa8ac3d0f87395f986314897b835a"}
