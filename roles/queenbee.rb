name "queenbee"
description "Queenbee"
recipes "backup::client"
default_attributes :active_applications =>  {"queenbee" =>  {"env" =>  "production"}},
                   :applications => {
                     :queenbee => {
                       :gems => ['fast_xs'],
                       :domains => "*.37signals.com"
                     }
                   },
                   :active_groups => {:storage => {:enabled => true}}
                   