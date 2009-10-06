name "highrise"
description "Highrise production"
default_attributes  :active_applications =>  {"highrise" =>  {"env" =>  "production"}},
                    :nfs_mounts => {
                    "/u/nfs/file1/depot"  =>  {"device" => "172.28.1.66:/u/depot",  "owner"  => "app"},
                    "/u/nfs/file2/depot"  =>  {"device" => "172.28.1.67:/u/depot",  "owner"  => "app"},
                    "/u/nfs/file3/depot"  =>  {"device" => "172.28.1.70:/u/depot",  "owner"  => "app"}},
                    :applications => {
                      :highrise => {
                        :syslog_files => {:haproxy => true},
                        :gems => ['fast_xs','hpricot', 'open4', 'bcrypt-ruby'],
                        :packages => ['imagemagick', 'zip'],
                        :symlinks => {
                        '/usr/local/bin/convert' => '/usr/bin/convert',
                        '/usr/local/bin/identify' => '/usr/bin/identify',
                        '/usr/local/bin/composite' => '/usr/bin/composite',
                        '/usr/local/bin/zip' => '/usr/bin/zip',
                        '/u/depot' => '/u/nfs/file1/depot',
                        '/usr/local/bin/iconv' => '/usr/bin/iconv'},
                        :apache_modules => ["auth_token", "xsendfile", "rewrite"]
                      }
                    }
override_attributes :passenger => { :tune_gc => true }
