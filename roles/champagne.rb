name "champagne"
description "Champagne"
default_attributes :active_applications =>  {"champagne" =>  {"env" =>  "production"}},
                   :applications => {
                     :champagne => {
                       :gems => ['fast_xs']
                     }
                   }