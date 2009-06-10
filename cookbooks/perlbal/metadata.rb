maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures perlbal"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "perlbal",
  :display_name => "",
  :description => "",
  :recipes => [ "perlbal" ],
  :default => ""
