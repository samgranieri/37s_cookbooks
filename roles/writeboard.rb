name "writeboard"
description "Writeboard"
default_attributes :active_applications =>  {"writeboard" =>  {"env" =>  "production"}},
                   :gems => ['fast_xs'],
                   :packages => ['elinks'],
                   :symlinks => {'/usr/local/bin/elinks' => '/usr/bin/elinks'}
                    