maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures nagios"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "nagios::checks"
recipe            "nagios::client"
recipe            "nagios::server"

attribute         "client",
  :display_name => "",
  :description => "",
  :recipes => [ "nagios" ],
  :default => ""

attribute         "server",
  :display_name => "",
  :description => "",
  :recipes => [ "nagios" ],
  :default => ""
