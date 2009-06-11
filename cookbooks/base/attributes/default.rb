ddclient Mash.new unless attribute?("ddclient")
users Mash.new unless attribute?("users")
groups Mash.new unless attribute?("groups")
ssh_keys Mash.new unless attribute?("ssh_keys")
host_keys Mash.new unless attribute?("host_keys")
sudo Mash.new unless attribute?("sudo")
roles Mash.new unless attribute?("roles")
applications Mash.new unless attribute?("applications")
sites Mash.new unless attribute?("sites")
nameservers Array.new unless attribute?("nameservers")
postfix Mash.new unless attribute?("postfix")
hosts Mash.new unless attribute?("hosts")
public_domain String.new unless attribute?("public_domain")

case domain
  when "rack-dfw-int.37signals.com"
    # dns-01, dns-02, noc
    nameservers ['192.168.2.63', '192.168.2.65', '192.168.1.157']
    postfix[:myorigin] = "virt-gw.37signals.com"
    public_domain "rack-dfw.37signals.com"
    
  when "ec2-us-int.37signals.com"
    nameservers ['10.252.194.239']
    hosts[:entries] = [['10.252.194.239', 'noc']]
    postfix[:myorigin] = fqdn
    public_domain "ec2-us.37signals.com"
  else
    postfix[:myorigin] = fqdn
end

host_keys[:dev] = "|1|KvHRKrGy/30YCtj0Lc9M5HEwdu8=|b2VJ1rh2Ep44lRyaBSv/Ujrp7g8= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArjrY9fx5IPyjawRtv1sOu5x8SRvPf+zek//zyPSDxL5up/AfxJZEVUDitJhKbIkSHADX4s9MMueh4QIxftaZPvxQiGG36PczkrxZ0Ob8aIz+pVUvxooe1AOTN/AxGA0AvPDVjJdy1d1PKbxb0w7o4jKFaitxlYp+WlgMBzXCnx7uXDxwtnID/0mICX9d9fnnA8Qf2biFcl2dhQWXiZccsZEaI85CRymNSPHuUOcbZg84No9lEeu5rnMqV8MoJ4VG6GFDdyZyiR/FkmwlTh4Ma9+klfImRQNdN//+fob/JoBpygxzuacT2tcXI/SCYfEoTSbpHE4CvxloRst9Gb8XlQ=="