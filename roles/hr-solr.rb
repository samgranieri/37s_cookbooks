name "solr"
description "HR Solr search server"
recipes "solr", "nfs::client", "syslog::client", "rails::app_dependencies"

default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
