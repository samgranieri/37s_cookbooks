name "yubikey"
description "Yubikey Validation/Management Server"
recipes "php5::sites"

default_attributes :active_sites => { :yubikey => { "env" => "production" }}
