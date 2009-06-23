name "noc"
description "Network opertions server"
recipes "basecamp", "highrise", "jobs", "backpack", "blogcabin", "bookstore", "campfire", "extra_extra", "forum", "help", "openbar", "queenbee", "writeboard",
        "syslog::server", "nagios::server", "apt::mirror"
default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
