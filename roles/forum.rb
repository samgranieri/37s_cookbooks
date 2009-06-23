name "forum"
description "Campfire production"
default_attributes :active_applications =>  {"forum" =>  {"env" =>  "production"}},
                    :gems => [['ruby-openid', '1.1.4'], 'RedCloth']