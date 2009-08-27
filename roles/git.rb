name "git"
description "Git source server"
recipes "git::server"
default_attributes :active_groups => {:app => {:enabled => true}, :git => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
