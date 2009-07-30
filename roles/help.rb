name "help"
description "Support help app"
default_attributes :active_applications =>  {"help" =>  {"env" =>  "production"}},
                   :applications => {
                                       :bookstore => {
                                        :gems => ['fast_xs', "RedCloth"]
                                       }
                                     }