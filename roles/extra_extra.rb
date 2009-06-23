name "extra_extra"
description "Extra extra"
default_attributes :active_applications =>  {"extra_extra" =>  {"env" =>  "production"}},
                   :applications => {
                     :extra_extra => {
                       :gems => ['fast_xs']
                     }
                   }