name "staging"
description "Staging server"
recipes "rails::apps", "syslog::client", "mysql::server", "erlang", "haproxy", "memcached::basic"

default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}},
                   "mysql" => {
                     "instances" => [
                       { 
                         "name" => "staging",
                         "version" => "5.0.84-percona",
                         "config" => { "innodb_buffer_pool_size" => "64M" }
                       }
                     ]
                   }
                   
