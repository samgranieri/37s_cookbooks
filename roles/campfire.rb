name "campfire"
description "Campfire production"
default_attributes :active_applications =>  {"campfire" =>  {"env" =>  "production"}},
                   :applications => {
                     :campfire => {
                       :syslog_files => {:haproxy => true},
                        :gems => ['fast_xs', 'hpricot', 'mime-types', ['tzinfo', '0.3.9'], 'xml-simple', 'bcrypt-ruby'],
                        :packages => ['imagemagick', 'libfcgi-dev'],
                        :symlinks => {
                          '/usr/local/bin/convert' => '/usr/bin/convert',
                          '/usr/local/bin/identify' => '/usr/bin/identify',
                          '/usr/local/bin/composite' => '/usr/bin/composite'
                        },
                        :apache_modules => ["auth_token", "xsendfile", "rewrite"],
                        :domains => ["*.campfirenow.com"]
                      }
                    }
override_attributes :apache => {:ports => [80,443]},
                    :passenger => { :tune_gc => true }
