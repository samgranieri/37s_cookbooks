maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures syslog"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "syslog::client"
recipe            "syslog::server"

attribute         "default",
  :display_name => "",
  :description => "",
  :recipes => [ "syslog" ],
  :default => ""
