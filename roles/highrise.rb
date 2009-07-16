name "highrise"
description "Highrise production"
default_attributes  :active_applications =>  {"highrise" =>  {"env" =>  "production"}},
                    :postfix => {
                      :virtual_domains => {
                        "/^([^@]+\.)?highrisehq\.com$/" => "VIRTUAL",
                        "/^(forum\.)?highrisehq\.com$/" => "VIRTUAL",
                        "/^dropbox(\+.+)?@(\d+)\.([^\.]+)\.highrisehq\.com$/" => "highrise@localhost",
                        "/^case\+dropbox@(\d+)\.([^\.]+)\.highrisehq\.com$/"  => "highrise@localhost",
                        "/^deal\+dropbox@(\d+)\.([^\.]+)\.highrisehq\.com$/"  => "highrise@localhost",
                        "/^task(\+.+)?@(\d+)\.([^\.]+)\.highrisehq\.com$/"    => "highrise@localhost",
                        "/^postmaster@highrisehq\.com$/"                      => "postmaster@37signals.com",
                        "/^cancel@highrisehq\.com$/"                          => "37signals.support@gmail.com",
                        "/^hr-cron@37signals\.com$/"                          => "hr-exceptions@37signals.com",
                        "/^solr-cron@37signals\.com$/"                        => "solr@37signals.com",
                        "/^support@highrisehq\.com$/"                         => "37signals.support@gmail.com",
                        "/^bounces@highrisehq\.com$/"                         => "devnull",
                        "/^system@highrisehq\.com$/"                          => "devnull",
                        "/@forum\.highrisehq\.com$/"                          => "devnull"
                      }
                    },
                    :nfs_mounts => {
                    "/u/nfs/file1/depot"  =>  {"device" => "172.28.1.66:/u/depot",  "owner"  => "app"},
                    "/u/nfs/file2/depot"  =>  {"device" => "172.28.1.67:/u/depot",  "owner"  => "app"},
                    "/u/nfs/file3/depot"  =>  {"device" => "172.28.1.70:/u/depot",  "owner"  => "app"},
                    "/u/nfs/netapp/depot" =>  {"device" => "172.28.2.6:/vol/depot", "owner" => "app"}},
                    :applications => {
                      :highrise => {
                        :syslog_files => {:haproxy => true},
                        :gems => ['fast_xs','hpricot'],
                        :packages => ['imagemagick', 'zip'],
                        :symlinks => {
                        '/usr/local/bin/convert' => '/usr/bin/convert',
                        '/usr/local/bin/identify' => '/usr/bin/identify',
                        '/usr/local/bin/composite' => '/usr/bin/composite',
                        '/usr/local/bin/zip' => '/usr/bin/zip',
                        '/u/depot' => '/u/nfs/file1/depot',
                        '/u/apps/highrise/shared/data' => "/u/depot/highrise",
                        '/usr/local/bin/iconv' => '/usr/bin/iconv'},
                        :apache_modules => ["auth_token", "xsendfile", "rewrite"]
                      }
                    }
override_attributes :passenger => { :tune_gc => true }
