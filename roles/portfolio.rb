name "portfolio"
description "Portfolio asset server"
default_attributes  :active_applications =>  {"portfolio" =>  {"env" => "production"}},
                    :applications => {
                      :portfolio => {
                        :gems => ['bundler'],
                        :packages => ['imagemagick', 'libmagick9-dev'],
                        :rack_config => true,
                        :domains => ["*.37signals.com"]
                      }
                    },
                    :rails => {:web_server => "nginx", :app_server => "unicorn"}
                    

override_attributes :passenger => { :tune_gc => true }
