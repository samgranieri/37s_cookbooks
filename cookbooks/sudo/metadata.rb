maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures sudo"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "sudoers",
  :display_name => "",
  :description => "",
  :recipes => [ "sudo" ],
  :default => ""
