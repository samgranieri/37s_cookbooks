name "mogilefs"
description "MogileFS server"
recipes "mogilefs::storenode", "mogilefs::tracker"
default_attributes :mogilefs => {
                     :mogilefsd => { 
                       :db_pass => "uXM5gBLHMnSgkZTyYfFw",
                       :listener_jobs => "10",
                       :delete_jobs => "2"
                     }
                   },
                   :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}