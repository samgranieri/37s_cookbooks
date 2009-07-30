name "37s-app"
description "General 37s application server"

recipes "rails::apps", "php::sites"

override_attributes :active_applications => {
                     :bookstore => {"env" => "production"},
                     :blogcabin => {"env" => "production"},
                     :forum => {"env" => "production"},
                     :jobs => {"env" => "production"},
                     :extra_extra => {"env" => "production"}
                   },
                   :active_sites => {
                     "37signals" => {"env" =>"production"},
                     :developer => {"env" =>"production"},
                     :basecamphq => {"env" =>"production"},
                     :backpackit => {"env" =>"production"},
                     :campfirenow => {"env" =>"production"},
                     :tadalist => {"env" =>"production"},
                     :writeboard => {"env" =>"production"},
                     :highrisehq => {"env" =>"production"}
                   },
                   "apache" => {"listen_ports" => ["80","443"]},
                   "passenger" => {"max_pool_size" => "12", "use_global_queue" => "on", "rails_env" => "production"},
                   "php5" => {"version" => "5.2.9"},
                   "hosts" => {"localhost_aliases" => ["basecamp.forum.37signals.com", "backpack.forum.37signals.com", "highrise.forum.37signals.com"]}