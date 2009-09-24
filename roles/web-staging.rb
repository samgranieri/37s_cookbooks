name "web-staging"
description "Staging slice for smaller sites/apps"
recipes "mysql::server", "php5::sites", "rails::apps", "rails::delayed_job"
default_attributes :users => {:app => {:extra_ssh_keys => [:nagios, :solr, :pratik]}},
                  :active_groups => {:contractors => {:enabled => true}},
                  "active_applications" => {"blogcabin" => {"env" => "staging"},
                 "bookstore" => {"env" => "staging"},
                 "jobs" => {"env" => "staging"},
                 "help" => {"env" => "staging"},
                 "extra_extra" => {"env" => "staging"},
                 "haystack" => {"env" => "staging"},
                 "openbar" => {"env" => "staging"},
                 "champagne" => {"env" => "staging"}},
                  "active_sites" => {"37signals" => {"env" => "staging"},
                  "backpackit" => {"env" => "staging"},
                  "highrisehq" => {"env" => "staging"}}

  
