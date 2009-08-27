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
                   }
