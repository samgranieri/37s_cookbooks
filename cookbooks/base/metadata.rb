maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures base"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "base::appserver"

attribute         "default",
  :display_name => "",
  :description => "",
  :recipes => [ "base" ],
  :default => ""
