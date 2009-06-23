name "forum"
description "Campfire production"
default_attributes :active_applications =>  {"forum" =>  {"env" =>  "production"}},
                   :applications => {
                     :forum => {
                       :gems => [['ruby-openid', '1.1.4'], 'RedCloth']
                     }
                   }