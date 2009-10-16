name "haystack"
description "Haystack"
default_attributes :active_applications => {"haystack" => {"env" => "production"}},
                   :applications => {
                     :haystack => {
                       :domains => ["haystack.com"],
                       :gems => ['fast_xs', 'xml-simple', 'right_aws', 'bcrypt-ruby', 'erubis', 'aws-s3'],
                       :packages => ["imagemagick"],
                       :syslog_send_to_host => ("192.168.2.138"),
                       :delayed_job => true
                     }
                   },
                   :delayed_jobs => {:enabled => true, :rails_env => "staging", :app_name => "haystack"},
                   :rails => {:web_server => "nginx", :app_server => "unicorn"}
