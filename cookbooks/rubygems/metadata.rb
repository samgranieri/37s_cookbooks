maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures rubygems"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "rubygems::client"
recipe            "rubygems::mirror"

attribute         "client",
  :display_name => "",
  :description => "",
  :recipes => [ "rubygems" ],
  :default => ""

attribute         "mirror",
  :display_name => "",
  :description => "",
  :recipes => [ "rubygems" ],
  :default => ""
