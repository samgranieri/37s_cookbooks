base Mash.new unless attribute?("base")

base[:sysadmin_email] = "sysadmins@37signals.com"
base[:sysadmin_sms_email] = "sysadmins@37signals.com"
base[:campfire_subdomain] = "37s"
base[:campfire_email] = "monitoring@37signals.com"
base[:campfire_password] = "0hs0tast33"
base[:sysadmin_campfire_room] = "System Administration"
base[:clickatell_username] = "37signals"
base[:clickatell_api_id] = "3131956"
base[:clickatell_password] = "EIJVhiv4"
base[:default_domain] = "37signals.com"

users Mash.new unless attribute?("ddclient")
users Mash.new unless attribute?("users")
groups Mash.new unless attribute?("groups")
ssh_keys Mash.new unless attribute?("ssh_keys")
sudo Mash.new unless attribute?("sudo")

ddclient[:dyndns_login] = "883mhi-ec2dyn"
ddclient[:dyndns_password] = "5SkR2hJiNsQP"

groups[:app]   = {:gid => 1000}
groups[:site]  = {:gid => 1001}
groups[:admin] = {:gid => 2000}

users[:app]    = {:password => "$1$hk40k332$wpSYJYlbbVo3AK/7thxO3.", :comment => "App User", :uid => 1000, :gid => 1000, :ssh_keys => [:david,:joshua,:mark]}
users[:site]   = {:password => "$1$4k01kee3$tQkwp46/ngyG.iH4kIaTJ0", :comment => "Site User", :uid => 1001, :gid => 1001, :ssh_keys => [:david,:joshua,:mark]}
users[:david]  = {:password => "$1$1EcOMWnu$E/TtE2ODkJKKiOgOq14Sq1", :comment => "DHH", :uid => 1002, :gid => 1000}
users[:joshua] = {:password => "$1$vRx7xHSn$xXL0.q9zIfV/p/sm9EDLQ/", :comment => "Joshua Sierles", :uid => 1003, :gid => 2000}
users[:mark]   = {:password => "$1$/Tksj8KW$Vqswv0AALCtHLMog3z6kk/", :comment => "Mark Imbriaco", :uid => 1004, :gid => 2000}
# jason $1$uZBGnixP$IObtQbltwN/OMqYOvETgo.
# ryan $1$F4RLmWHq$SmMk24KYh/M0UPCqEfJ3s1
# jamis $1$KXwTGx4Z$cJrqEqZ8DcsmIzXjz.nMH0
# sam $1$6cIAM7hX$4w6vLIp2Wp8at6VksADJg0
ssh_keys[:david]  = "ssh-dss AAAAB3NzaC1kc3MAAAEBAMz5mPUa2WubrwTgE1VXPdmPSkT0qoU71vh4elJRaj0VWypb2c3IPyyGSdWjsCBSHUSUBUR4VL5fSJfu1QKrHVpt0BIU7Nl+dvCwATAeL9j3k0cpzYrjPhXLZQ4UStfh+Tpo20QitzXQ2ceoFaiVNXf5upUP+Yz+jTqhLkcjWVlIdas/eiVldXVtLEUqUo6RUTcaVLbb8ksp6lhZp1iVV8k07OMButiCB3X3k5kQxCnCMzzWI5IDP6VSacu5gUwIjnS2hB0S3lSBSgJL+YBOBWqjBW4HCqPHMkphEyxUs0GtVia1qdhIs62m8tMMD6hWiqr7+ATJi0xf0iI31TjUxSUAAAAVAPS7EZNGzL+bknalDVdd5JpTFlqfAAABAD1fD+2u1fAh/pMeUnj7fwNGVEH0NwjePLyrZiCV1qvcqfR2FOH6pJS5ntQPgo+bi33MnkXqp/dnkEdpWar/CRo9FgIcyQ4NUSkXYwlhY6HM+PxTQvM5WhRMpJqfcfQKXdhV8hlf293p5roWYmbale4vq+Kz+bpVnIxO+UQqvb1nbnbzB9/ztWWjKwTKUPklvja52g3tWYH1tywzGVHukLoiedZGwqw3kHT8FQgORAr2AbE8Bn++cT6PUr78PXUl537OLVTwtNPK/taB8mm4Fwbriz9fiEdvgtfsji+1vqkJubeUmQi8TPq5iwsthE3TPyY6Ip1ZJlPO8LTXENGyvD8AAAEAUYs2ZCRntt59ryfOsXiu4J/vYpzbSbBqXmX5wBzbb23qmZGd8LBLzUY6NwgR6NbD41e0qx31IGK5KE8fFX/z+oaZfQBw/Vt72QuyypdMcqYXVN4/AOv4u8+pqb7q+m1qULgGoi+/DMKE61mxw0+iiFz+drUr3ZF+9weuVE+xWlBWIze+GOBxMDVrKjvK4wuGFl67gD8F5/wcA8pRDltYVYgwkuf22L+o1ZvYRt+4861kAUfqeP2HM24+swXgPOK1Mi/3AZupqTFTSB1NruDlvd2xBKAMqSMv9sIc0y89cATd9Divusb85zRJVsIGQz19l7UUgA0Ogvwdm0+t4zr2Kw== david@Envy5.local"
ssh_keys[:joshua] = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAw942jLhdXBPHljWtE42B1XeFuWSJU/+w4pVTwdID6KEf8KF1cx/Jc0EJnA2ipMgJtUCJolWyt0PdGcqf8oE7UbrkzCW78g+zLa8muxUdHF6JK0b/nQW0plj8rg3rTxTz4lIi46AgW1iC9XXKlcX1IRC3w0Y9Lu+RMyGxdifFNHSj3g+Vd2QfHJBQkQz4Nx1ngT+y6y/966K/AIJHej67MmuCHRTxMKxX5vxmbvHP8WgSvylgx+mkTuYhUzGaQtvopM6zzXLfIsicnxVIu1hWjXlle55t0EamGysjGrJFbYiunbWDlwRfZOBe/ZKec5rBPLxwBC1xQ2F4sOJFUE+iUQ== jsierles@MacAir.local"
ssh_keys[:mark]   = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0TNuoIMw5w7LgDm2RpGRIgPVxk7Ks1Y6Mque5KisLM02jbq4WdT1xsjtN74ibnAzG51vkjSgqRmXmmqiiDvafD06fTf6QrM3LZ7L1sOMu/ovKcKtISIwcU0kOzVvq9WXWinhm99iL11CUvA/gGIavHNmAfleq5NZr3uSV2r+PyZerOCcJH3D3c8iT22+8MZO9KNELlaXq+pYqbmfyGzEJuLD3VM94+VW2oFnBuRFMdmd6N6ts2+JOYLUUqH8T0S3D1tchSGSMaRV0gO8+4IH8GcUPI2DpQYsz8eW/90+cOfRaDqqIL1uJbS+ORESlMPqoamtXCdYrTBqsPgKyLhM5Q== mark@strongbad"

sudo[:users] = [:david]
sudo[:groups] = [:admin]