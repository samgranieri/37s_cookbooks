name "solr"
description "Solr search server"
recipes "solr", "rails::app_dependencies"

default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
