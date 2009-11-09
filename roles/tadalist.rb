name "tadalist"
description "Tadalist"
default_attributes :applications => {
                     :tadalist => {
                       :gems => ['fast_xs'],
                       :domains => ["tadalist.com"]
                     }
                   },
                   :active_applications =>  {"tadalist" =>  {"env" =>  "production"}}