name "highrise"
description "Highrise production"
default_attributes  :active_applications =>  {"highrise" =>  {"env" =>  "production"}},
                    :applications => {
                      :highrise => {
                        :syslog_files => {:haproxy => true},
                        :gems => ['fast_xs','hpricot', 'open4', 'bcrypt-ruby', "xml-simple"],
                        :packages => ['imagemagick', 'zip', 'ffmpeg'],
                        :symlinks => {
                        '/usr/local/bin/convert' => '/usr/bin/convert',
                        '/usr/local/bin/identify' => '/usr/bin/identify',
                        '/usr/local/bin/composite' => '/usr/bin/composite',
                        '/usr/local/bin/zip' => '/usr/bin/zip'
                        '/usr/local/bin/iconv' => '/usr/bin/iconv'},
                        :apache_modules => ["auth_token", "xsendfile", "rewrite"],
                        :domains => ["*.highrisehq.com"]
                      }
                    }
override_attributes :passenger => { :tune_gc => true }
