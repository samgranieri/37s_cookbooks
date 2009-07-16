name "memcache"
description "Mail server"
recipes "postfix::virtual"
default_attributes :postfix => {
  :virtual_domains => {
    "/^virt-gw\.37signals\.com$/" => "VIRTUAL",
    "/^app@virt-gw\.37signals\.com$/" => "devnull@localhost"
}
