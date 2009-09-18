name "37s-app"
description "General 37s application server"

recipes "rails::apps"

override_attributes :active_applications => {
                     :bookstore => {"env" => "production"},
                     :blogcabin => {"env" => "production"},
                     :forum => {"env" => "production"},
                     :jobs => {"env" => "production"},
                     :extra_extra => {"env" => "production"},
                     :champagne => {"env" => "production"}
                   },
                   :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}},

                   "apache" => {"listen_ports" => ["80","443"]},
                   "passenger" => {"max_pool_size" => "12", "use_global_queue" => "on", "rails_env" => "production"},
                   "hosts" => {"localhost_aliases" => ["basecamp.forum.37signals.com", "backpack.forum.37signals.com", "highrise.forum.37signals.com"]}
