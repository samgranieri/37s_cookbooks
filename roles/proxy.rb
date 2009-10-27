name "proxy"
description "Proxy server"
recipes "haproxy", "keepalived"

default_attributes :active_groups => {:app => {:enabled => true}},
:haproxy => {
  :instances => {
    :mail_relay => {
      :listeners => {
        :mail_relay_pool => {
          :ip => "0.0.0.0",
          :port => "22001",
          :mode => "tcp",
          :admin_port => "22002",
          :backends => {
            "mail-relay-01" => {
              :ip => "192.168.2.139",
              :port => "25",
              :options => "check"
            },
            "mail-relay-02" => {
              :ip => "192.168.2.141",
              :port => "25",
              :options => "check"
            }
          }
        }
      }
    }
  }
}