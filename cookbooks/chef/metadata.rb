maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures chef"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "chef::client"
recipe            "chef::server"

attribute         "client",
  :display_name => "",
  :description => "",
  :recipes => [ "chef" ],
  :default => ""

attribute         "server",
  :display_name => "",
  :description => "",
  :recipes => [ "chef" ],
  :default => ""
