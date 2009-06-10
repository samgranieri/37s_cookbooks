maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures couchdb"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "couchdb",
  :display_name => "",
  :description => "",
  :recipes => [ "couchdb" ],
  :default => ""
