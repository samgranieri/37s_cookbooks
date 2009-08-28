name "git"
description "Git source server"
recipes "git::server", "cron"
default_attributes :active_groups => {:app => {:enabled => true}, :git => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}},
                   :cron => {
                     :jobs => {
                       :git_mirrors => {
                         :minute => "*/2",
                         :command => "/u/git/mirrors/update_all_mirrors.sh > /dev/null",
                         :user => "git"
                       }
                     }
                   },
                   :git => {
                     :repos => {
                       :basecamp => {},
                       :backpack => {},
                       "basecamp-help" => {},
                       :blogcabin => {},
                       :bookstore => {},
                       :campfire => {},
                       :cardstore => {},
                       :champagne => {},
                       :chef_recipes => {},
                       :compass => {},
                       :extra_extra => {},
                       :forum => {},
                       :extra_extra => {},
                       "gitosis-admin" => {},
                       :extra_extra => {},
                       :haystack => {},
                       :help => {},
                       :highrise => {},
                       :homedirs => {},
                       :jobs => {},
                       :limechicken => {},
                       :live => {},
                       "materials/37signals_materials" => {},
                       "materials/basecamp_materials" => {},
                       "materials/campfire_materials" => {},
                       "materials/highrise_materials" => {},
                       "materials/bascamp_materials" => {},
                       :mirror => {},
                       "mirrors/googlecharts" => {},
                       "mirrors/mogilefs-client" => {},
                       "mirrors/plugins/country_and_region_select" => {},
                       "mirrors/plugins/deadlock_retry" => {},
                       "mirrors/plugins/exception_notification" => {},
                       "mirrors/plugins/open_id_authentication" => {},
                       "mirrors/prototype" => {},
                       "mirrors/rails" => {},
                       "mirrors/scriptaculous" => {},
                       "mirrors/sprockets" => {},
                       "mirrors/sprockets-rails" => {}
                     }
                   }
