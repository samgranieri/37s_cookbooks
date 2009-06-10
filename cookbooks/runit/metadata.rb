maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures runit"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "sv_bin",
  :display_name => "",
  :description => "",
  :recipes => [ "runit" ],
  :default => ""
