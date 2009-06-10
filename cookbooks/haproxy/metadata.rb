maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures haproxy"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "haproxy",
  :display_name => "",
  :description => "",
  :recipes => [ "haproxy" ],
  :default => ""
