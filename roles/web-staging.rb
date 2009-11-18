name "web-staging"
description "Staging slice for smaller sites/apps"
recipes "mysql::server", "php5::sites", "rails::apps", "rails::delayed_job"
override_attributes :users => {:app => {:password => "$1$hk40k332$wpSYJYlbbVo3AK/7thxO3.", :comment => "App User", :uid => 1003, :groups => [:app], :ssh_key_groups => [:app,:site,:admin], :extra_ssh_keys => [:nagios, :solr, :pratik]}},
                   "active_applications" => {
                     "blogcabin" => {"env" => "staging"},
                     "bookstore" => {"env" => "staging"},
                     "jobs" => {"env" => "staging"},
                     "help" => {"env" => "staging"},
                     "extra_extra" => {"env" => "staging"},
                     "openbar" => {"env" => "staging"},
                     "champagne" => {"env" => "staging"},
                     "portfolio" => {"env" => "staging"}
                   },
                   "active_sites" => {
                     "37signals" => {"env" => "staging"},
                     "backpackit" => {"env" => "staging"},
                     "highrisehq" => {"env" => "staging"}
                   },
                   "mysql" => {
                     "instances" => [
                       { 
                         "name" => "web_staging",
                         "version" => "5.0.84-percona",
                         "config" => { "innodb_buffer_pool_size" => "64M" }
                       }
                     ]
                   }
