name "jobs"
description "Jobs"
default_attributes :active_applications =>  {"jobs" =>  {"env" =>  "production"}},
                   :gems => ['fast_xs', 'RedCloth', 'mime-types', "xml-simple"]
