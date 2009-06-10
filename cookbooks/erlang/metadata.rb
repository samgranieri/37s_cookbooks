maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures erlang"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "erlang",
  :display_name => "",
  :description => "",
  :recipes => [ "erlang" ],
  :default => ""
