name 'mail-relay'
description 'Mail relay server'
recipes 'cron', 'syslog::client'

override_attributes :active_groups => {:app => {:enabled => true}},
                    :active_sudo_groups => {:app => {:enabled => true}},
                    :postfix => { :mynetworks => [ '192.168.0.0/22', '172.28.0.0/16' ] },
                    :sysctl => {
                      :settings => {
                        "net.ipv4.tcp_window_scaling" => "0"
                        }
                    }
