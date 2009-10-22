name "memcache"
description "Memcache server"
recipes "memcached::instances"
default_attributes :memcached => {
                     :instances => {  
                       :basecamp => {"max_memory" => "256", "port" => "11211"},
                       :backpack => {"max_memory" => "768", "port" => "11212"},
                       :shared   => {"max_memory" => "256", "port" => "11213"},
                       :highrise => {"max_memory" => "1024", "port" => "11214"},
                       :campfire => {"max_memory" => "256", "port" => "11215"}
                     }
                   }
override_attributes  :nagios => {
                     :checks => {
                       :memory => {
                         :critical => 100,
                         :warning => 120
                       }
                     }
                   }