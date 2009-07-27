name "live"
description "37s live app"
default_attributes :active_applications =>  {"live" => {"env" =>  "production"}},

:applications => {
  :live => {
    :gems => ['fast_xs']
  }
}