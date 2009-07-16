name "writeboard"
description "Writeboard"
default_attributes :active_applications =>  {"writeboard" =>  {"env" =>  "production"}},
                   :postfix => {
                     :virtual_domains => {
                       "/^writeboard\.com$/" => "VIRTUAL",
                       "/^postmaster@writeboard\.com$/" => "postmaster@37signals.com",
                       "/^support@writeboard\.com$/" => "37signals.support@gmail.com",
                       "/^system@writeboard\.com$/" => "wb-system"
                     }
                   },
                   :applications => {
                     :writeboard => {
                       :gems => ['fast_xs'],
                       :packages => ['elinks'],
                       :symlinks => {'/usr/local/bin/elinks' => '/usr/bin/elinks'} 
                     } 
                   }