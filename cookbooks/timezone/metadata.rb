maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures timezone"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "timezone",
  :display_name => "",
  :description => "",
  :recipes => [ "timezone" ],
  :default => ""
