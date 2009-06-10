name "base"
description "Base role that applies to all servers"
recipes "hosts", "syslog::client", "dns::client", "nagios::client", "rubygems::client", "timezone", "git", "postfix", "ssh::server"