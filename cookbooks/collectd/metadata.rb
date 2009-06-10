maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures collectd"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "collectd",
  :display_name => "",
  :description => "",
  :recipes => [ "collectd" ],
  :default => ""
