# Example role for a Rails application server with nfs mounts and remote syslogging
name "app"
description "Basic Rails application server"
recipes "rails::apps", "syslog::client", "nfs::client"

default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
