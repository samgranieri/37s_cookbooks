maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures ec2"
long_description  "Configures#{cookbook.name}"
version           "0.1"
recipe            "ec2::filesystems"

attribute         "default",
  :display_name => "",
  :description => "",
  :recipes => [ "ec2" ],
  :default => ""
