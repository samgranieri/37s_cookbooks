name "queenbee"
description "Queenbee"
default_attributes :active_applications =>  {"queenbee" =>  {"env" =>  "production"}},
                   :applications => {
                     :queenbee => {
                       :gems => ['fast_xs']
                     }
                   }