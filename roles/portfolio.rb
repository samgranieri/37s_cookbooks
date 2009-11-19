name "portfolio"
description "Portfolio asset server"
default_attributes  :active_applications =>  {"portfolio" =>  {"env" => "production"}},
                    :applications => {
                      :portfolio => {
                        :gems => ['bundler'],
                        :packages => ['imagemagick', 'libmagick9-dev']
                      }
                    }

override_attributes :passenger => { :tune_gc => true }
