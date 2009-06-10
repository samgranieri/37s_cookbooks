maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures integrity"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "integrity",
  :display_name => "",
  :description => "",
  :recipes => [ "integrity" ],
  :default => ""
