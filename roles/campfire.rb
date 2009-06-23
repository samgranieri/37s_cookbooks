name "cf-app"
description "Campfire production"
default_attributes :active_applications =>  {"campfire" =>  {"env" =>  "production"}},
                   :applications => {
                     :campfire => {
                       :syslog_files => {:haproxy => true},
                       :nfs_mounts => {
                        "/u/nfs/file1/depot"  =>  {"device" => "172.28.1.66:/u/depot",  "owner"  => "app"},
                        "/u/nfs/file2/depot"  =>  {"device" => "172.28.1.67:/u/depot",  "owner"  => "app"},
                        "/u/nfs/file3/depot"  =>  {"device" => "172.28.1.70:/u/depot",  "owner"  => "app"},
                        "/u/nfs/netapp/depot" =>  {"device" => "172.28.2.6:/vol/depot", "owner" => "app"}},
                        :gems => ['fast_xs', 'hpricot', 'mime-types', ['tzinfo', '0.3.9'], "xml-simple"],
                        :packages => ['imagemagick', 'libfcgi-dev'],
                        :symlinks => {
                          '/usr/local/bin/convert' => '/usr/bin/convert',
                          '/usr/local/bin/identify' => '/usr/bin/identify',
                          '/usr/local/bin/composite' => '/usr/bin/composite',
                          '/u/depot' => '/u/nfs/file1/depot'
                        },
                        :apache_modules => ["auth_token", "xsendfile", "fastcgi", "rewrite"]
                      }
                    }
