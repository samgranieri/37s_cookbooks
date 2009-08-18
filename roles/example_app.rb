# Example 'data' role containing general application specific data to recipes
name "example"
description "Example"
default_attributes  :active_applications =>  {"example" =>  {"env" =>  "production"}},
                    :applications => {
                      :backpack => {      
                        :gems => ['fast_xs', ['hpricot', '0.7'], 'aws-s3', 'ruby-prof', 'mime-types'],
                        :packages => ['imagemagick', 'elinks'],
                        :symlinks => {
                          '/usr/local/bin/elinks' => '/usr/bin/elinks'
                        },
                        :apache_modules => ["auth_token", "xsendfile", "rewrite"]
                      }
                    },
                    :nfs_mounts => {
                      "/u/nfs/example"  =>  {"device" => "1.2.3.4:/u/example",  "owner"  => "app"},
                    }
                    
override_attributes :apache => {:listen_ports => [80,443]},
                    :passenger => {:tune_gc => true}