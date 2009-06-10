maintainer        "37signals"
maintainer_email  "sysadmins@37signals.com"
description       "Configures ruby_enterprise_edition"
long_description  "Configures#{cookbook.name}"
version           "0.1"

attribute         "default",
  :display_name => "",
  :description => "",
  :recipes => [ "ruby_enterprise_edition" ],
  :default => ""
