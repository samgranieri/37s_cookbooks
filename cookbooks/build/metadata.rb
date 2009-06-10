maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures build"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "build",
  :display_name => "",
  :description => "",
  :recipes => [ "build" ],
  :default => ""
