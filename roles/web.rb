name "web"
description "Basic Rails web server"
recipes "rails::web", "syslog::client", "nfs::client"

default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
                   
override_attributes :sysctl => {
                     :settings => {
                       "net.ipv4.tcp_window_scaling" => "1"
                     }
                   }
