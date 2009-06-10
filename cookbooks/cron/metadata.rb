maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures cron"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "cron",
  :display_name => "",
  :description => "",
  :recipes => [ "cron" ],
  :default => ""
