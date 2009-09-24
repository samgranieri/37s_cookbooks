name "haystack"
description "Haystack"
default_attributes :applications => {
                     :haystack => {
                       :gems => ['fast_xs', 'xml-simple', 'right_aws'],
                       :packages => ["imagemagick"]
                     }
                   },
                   :delayed_jobs => {:enabled => true, :rails_env => "staging", :app_name => "haystack"}