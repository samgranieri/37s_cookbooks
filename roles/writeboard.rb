name "writeboard"
description "Writeboard"
default_attributes :active_applications =>  {"writeboard" =>  {"env" =>  "production"}},
                   :applications => {
                     :writeboard => {
                       :domains => ["123.writeboard.com"],
                       :gems => ['fast_xs', 'RedCloth'],
                       :packages => ['elinks'],
                       :symlinks => {'/usr/local/bin/elinks' => '/usr/bin/elinks'} 
                     } 
                   }
