name "backpack"
description "Backpack"
default_attributes  :active_applications =>  {"backpack" =>  {"env" =>  "production"}},
                    :applications => {
                      :backpack => {      
                        :gems => ['fast_xs', ['hpricot', '0.7'], 'aws-s3', 'ruby-prof', 'mime-types', 'bcrypt-ruby'],
                        :packages => ['imagemagick', 'elinks'],
                        :symlinks => {
                          '/usr/local/bin/convert' => '/usr/bin/convert',
                          '/usr/local/bin/identify' => '/usr/bin/identify',
                          '/usr/local/bin/composite' => '/usr/bin/composite',
                          '/usr/local/bin/elinks' => '/usr/bin/elinks'
                        },
                        :apache_modules => ["auth_token", "xsendfile", "rewrite"],
                        :domains => ["*.backpackit.com"]
                      }
                    }
                    
override_attributes :apache => {:listen_ports => [80,443]},
                    :passenger => {:tune_gc => true}
