name "web-staging"
description "Staging slice for smaller sites/apps"
recipes "mysql::server", "php5::sites", "rails::apps"
default_attributes "active_applications" => {"blogcabin" => {"env" => "staging"},
                 "bookstore" => {"env" => "staging"},
                 "jobs" => {"env" => "staging"},
                 "help" => {"env" => "staging"},
                 "extra_extra" => {"env" => "staging"},
                 "champagne" => {"env" => "staging"}},
 "active_sites" => {"37signals" => {"env" => "staging"},
                  "backpackit" => {"env" => "staging"},
                  "highrisehq" => {"env" => "staging"}}
  
