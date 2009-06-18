name "queenbee"
description "Queenbee"
default_attributes :active_applications =>  {"queenbee" =>  {"env" =>  "production"}},
                   :gems => ['fast_xs'],
                   :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
                   