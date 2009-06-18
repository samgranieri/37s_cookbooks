name "rack-dfw"
description "Servers in the Rackspace environment"
default_attributes :nameservers => ['192.168.2.63', '192.168.2.65', '192.168.1.157'],
                   :postfix => {:myorigin => "virt-gw.37signals.com"},
                   :public_domain => "rack-dfw.37signals.com",
                   :host_keys => {
                     :app => "|1|KvHRKrGy/30YCtj0Lc9M5HEwdu8=|b2VJ1rh2Ep44lRyaBSv/Ujrp7g8= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArjrY9fx5IPyjawRtv1sOu5x8SRvPf+zek//zyPSDxL5up/AfxJZEVUDitJhKbIkSHADX4s9MMueh4QIxftaZPvxQiGG36PczkrxZ0Ob8aIz+pVUvxooe1AOTN/AxGA0AvPDVjJdy1d1PKbxb0w7o4jKFaitxlYp+WlgMBzXCnx7uXDxwtnID/0mICX9d9fnnA8Qf2biFcl2dhQWXiZccsZEaI85CRymNSPHuUOcbZg84No9lEeu5rnMqV8MoJ4VG6GFDdyZyiR/FkmwlTh4Ma9+klfImRQNdN//+fob/JoBpygxzuacT2tcXI/SCYfEoTSbpHE4CvxloRst9Gb8XlQ=="
                   }