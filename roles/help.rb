name "help"
description "Support help app"
default_attributes :active_applications =>  {"help" =>  {"env" =>  "production"}},
                   :applications => {
                     :help => {
                      :gems => ['fast_xs', "RedCloth"]
                     }
                   }