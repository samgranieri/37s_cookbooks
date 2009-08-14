name "proxy"
description "Proxy server"
recipes "haproxy", "keepalived"

default_attributes :active_groups => {:app => {:enabled => true}}
