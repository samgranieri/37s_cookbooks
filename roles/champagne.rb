name "champagne"
description "Champagne"
default_attributes :active_applications =>  {"champagne" =>  {"env" =>  "production"}},
                   :applications => {
                     :blogcabin => {
                       :gems => ['fast_xs']
                     }
                   }