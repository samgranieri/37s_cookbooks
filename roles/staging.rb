name "staging"
description "Staging server"
recipes "mysql::server"
default_attributes :passenger => {:tune_gc => true}