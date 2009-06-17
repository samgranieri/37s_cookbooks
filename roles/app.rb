name "app"
description "Basic Rails application server"
recipes "rails::apps"
default_attributes :active_groups => {:dev => {:enabled => true}},
                   :active_sudo_groups => {:dev => {:enabled => true}}
