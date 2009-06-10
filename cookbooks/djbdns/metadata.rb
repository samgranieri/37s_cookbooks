maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures djbdns"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "djbdns::autozone"
recipe            "djbdns::axfr"
recipe            "djbdns::cache"
recipe            "djbdns::internal_server"
recipe            "djbdns::server"

attribute         "djbdns",
  :display_name => "",
  :description => "",
  :recipes => [ "djbdns" ],
  :default => ""
