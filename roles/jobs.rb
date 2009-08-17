name "jobs"
description "Jobs"
default_attributes :active_applications =>  {"jobs" =>  {"env" =>  "production"}},
                   :active_groups => { :app => { :enabled => true }},
                   :applications => {
                     :jobs => {
                       :gems => ['fast_xs', 'RedCloth', 'mime-types', "xml-simple"]                       
                     }
                   }
