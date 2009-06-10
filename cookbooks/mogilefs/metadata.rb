maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures mogilefs"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "mogilefs::storenode"
recipe            "mogilefs::tracker"

attribute         "mogilefs",
  :display_name => "",
  :description => "",
  :recipes => [ "mogilefs" ],
  :default => ""
