name "staging"
description "Staging server"
recipes "rails::apps", "syslog::client", "nfs::client", "mysql::server", "nfs::client", "erlang", "haproxy", "memcached::basic"

default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
