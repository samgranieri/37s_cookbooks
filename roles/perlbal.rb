name "perlbal"
description "Perlbal server"
recipes "perlbal"
default_attributes :mogilefs => {
                     :mogilefsd => { 
                       :db_pass => "uXM5gBLHMnSgkZTyYfFw",
                       :listener_jobs => "10",
                       :delete_jobs => "2"
                     }
                   }