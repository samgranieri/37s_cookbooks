name "haystack"
description "Haystack"
default_attributes :applications => {
                     :haystack => {
                       :gems => ['fast_xs', 'xml-simple'],
                       :packages => ["imagemagick"]
                     }
                   }