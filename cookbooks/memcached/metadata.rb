maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures memcached"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "memcached::basic"
recipe            "memcached::instances"

attribute         "memcached",
  :display_name => "",
  :description => "",
  :recipes => [ "memcached" ],
  :default => ""
