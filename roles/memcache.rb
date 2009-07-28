name "memcache"
description "Memcache server"
recipes "memcached::instances"
default_attributes :memcached => {
                     :instances => {  
                       :basecamp => {"max_memory" => "256", "port" => "11211"},
                       :backpack => {"max_memory" => "1024", "port" => "11212"},
                       :shared   => {"max_memory" => "256", "port" => "11213"},
                       :highrise => {"max_memory" => "1024", "port" => "11214"}
                     }
                   }
