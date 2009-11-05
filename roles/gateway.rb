name "gateway"
description "SSH Gateway Server"
recipes "gateway", "openvpn"

default_attributes :active_groups => {
                     :app => {:enabled => true},
                     :site => {:enabled => true},
                     :contractors => {:enabled => true},
                     :git => {:enabled => true}
                   }
