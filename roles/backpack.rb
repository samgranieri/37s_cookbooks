name "backpack"
description "Backpack"
default_attributes  :active_applications =>  {"backpack" =>  {"env" =>  "production"}},
                    :passenger => {:tune_gc => true},
                    :applications => {
                      :backpack => {      
                        :nfs_mounts => {
                          "/u/nfs/file1/depot"  =>  {"device" => "172.28.1.66:/u/depot",  "owner"  => "app"},
                          "/u/nfs/file2/depot"  =>  {"device" => "172.28.1.67:/u/depot",  "owner"  => "app"},
                          "/u/nfs/file3/depot"  =>  {"device" => "172.28.1.70:/u/depot",  "owner"  => "app"},
                          "/u/nfs/netapp/depot" =>  {"device" => "172.28.2.6:/vol/depot", "owner" => "app"}
                        },
                        :gems => ['fast_xs', ['hpricot', '0.7'], 'aws-s3', 'ruby-prof'],
                        :packages => ['imagemagick', 'elinks'],
                        :symlinks => {
                          '/usr/local/bin/convert' => '/usr/bin/convert',
                          '/usr/local/bin/identify' => '/usr/bin/identify',
                          '/usr/local/bin/composite' => '/usr/bin/composite',
                          '/usr/local/bin/elinks' => '/usr/bin/elinks',
                          '/u/depot' => '/u/nfs/file1/depot'
                        },
                        :apache_modules => ["auth_token", "xsendfile", "rewrite"]
                      }
                    },
                    :apache => {:listen_ports => [80,443]}