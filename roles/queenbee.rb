name "queenbee"
description "Queenbee"
default_attributes :active_applications =>  {"queenbee" =>  {"env" =>  "production"}},
                   :gems => ['fast_xs'],
                   :active_groups => {:dev => {:enabled => true}},
                   :active_sudo_groups => {:dev => {:enabled => true}}
                   