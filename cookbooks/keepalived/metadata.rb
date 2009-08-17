maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures keepalived"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "keepalived",
  :display_name => "",
  :description => "",
  :recipes => [ "keepalived" ],
  :default => ""
