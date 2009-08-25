name "staging"
description "Staging server"
recipes "rails::apps", "syslog::client", "nfs::client", "mysql::server", "nfs::client", "erlang"