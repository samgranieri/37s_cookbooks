maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures php5"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "php5",
  :display_name => "",
  :description => "",
  :recipes => [ "php5" ],
  :default => ""
