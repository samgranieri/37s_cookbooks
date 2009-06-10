maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures mysql"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "mysql::client"
recipe            "mysql::server"

attribute         "mysql",
  :display_name => "",
  :description => "",
  :recipes => [ "mysql" ],
  :default => ""

attribute         "server",
  :display_name => "",
  :description => "",
  :recipes => [ "mysql" ],
  :default => ""
