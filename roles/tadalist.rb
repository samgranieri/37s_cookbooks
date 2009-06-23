name "tadalist"
description "Tadalist"
default_attributes :applications => {
                     :tadalist => {
                       :gems => ['fast_xs']
                     }
                   },
                   :active_applications =>  {"tadalist" =>  {"env" =>  "production"}}