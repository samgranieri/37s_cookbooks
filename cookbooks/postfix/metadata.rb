maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures postfix"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "postfix",
  :display_name => "",
  :description => "",
  :recipes => [ "postfix" ],
  :default => ""
