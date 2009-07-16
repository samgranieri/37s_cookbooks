name "backpack"
description "Backpack"
default_attributes  :active_applications =>  {"backpack" =>  {"env" =>  "production"}},
                    :postfix => {
                      :aliases => {
                        "backpack"  => "|/usr/bin/sudo -u app /u/apps/backpack/current/script/email_helper"
                      },
                      :virtual_domains => {
                        "/^([^@]+\.)?backpackit\.com$/" => "VIRTUAL",
                        "/@([^@]+\.)backpackit\.com$/"  => "backpack@localhost",
                        "/^share@backpackit\.com$/"     => "37signals.support@gmail.com",
                        "/^support@backpackit\.com$/"   => "37signals.support@gmail.com",
                        "/^system@backpackit\.com$/"    => "37signals.support@gmail.com",
                        "/^alert@backpackit\.com$/"     => "devnull"
                      }
                    },
                    :applications => {
                      :backpack => {      
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
                    :nfs_mounts => {
                      "/u/nfs/file1/depot"  =>  {"device" => "172.28.1.66:/u/depot",  "owner"  => "app"},
                      "/u/nfs/file2/depot"  =>  {"device" => "172.28.1.67:/u/depot",  "owner"  => "app"},
                      "/u/nfs/file3/depot"  =>  {"device" => "172.28.1.70:/u/depot",  "owner"  => "app"},
                      "/u/nfs/netapp/depot" =>  {"device" => "172.28.2.6:/vol/depot", "owner" => "app"}
                    }
                    
override_attributes :apache => {:listen_ports => [80,443]},
                    :passenger => {:tune_gc => true}
