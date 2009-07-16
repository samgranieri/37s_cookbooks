name "tadalist"
description "Tadalist"
default_attributes :applications => {
                     :tadalist => {
                       :gems => ['fast_xs']
                     }
                   },
                   :postfix => {
                     :virtual_domains => {
                       "/^tadalist\.com$/"             => "VIRTUAL",
                       "/^postmaster@tadalist\.com$/"  => "postmaster@37signals.com",
                       "/^support@tadalist\.com$/"     => "37signals.support@gmail.com",
                       "/^tadalists\.com$/"            => "VIRTUAL",
                       "/^postmaster@tadalists\.com$/" => "postmaster@37signals.com",
                       "/^support@tadalists\.com$/"    => "jason"
                     }
                   },
                   :active_applications =>  {"tadalist" =>  {"env" =>  "production"}}