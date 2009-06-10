name "bc-app"
description "Basecamp production"
default_attributes :active_applications =>  {"basecamp" =>  {"env" =>  "production"}},
                   :nfs_mounts => {
                    "/u/nfs/file1/depot"  =>  {"device" => "172.28.1.66:/u/depot",  "owner"  => "app"},
                    "/u/nfs/file2/depot"  =>  {"device" => "172.28.1.67:/u/depot",  "owner"  => "app"},
                    "/u/nfs/file3/depot"  =>  {"device" => "172.28.1.70:/u/depot",  "owner"  => "app"},
                    "/u/nfs/netapp/depot" =>  {"device" => "172.28.2.6:/vol/depot", "owner" => "app"}}