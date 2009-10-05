name "haystack"
description "Haystack"
override_attributes :active_applications => {"haystack" => {"env" => "production"}},
                   :applications => {
                     :haystack => {
                       :gems => ['fast_xs', 'xml-simple', 'right_aws', 'bcrypt-ruby', 'erubis'],
                       :packages => ["imagemagick"]
                     }
                   },
                   :delayed_jobs => {:enabled => true, :rails_env => "staging", :app_name => "haystack"},
                   :rails => {:web_server => "nginx", :app_server => "unicorn"}
