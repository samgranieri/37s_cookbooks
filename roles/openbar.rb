name "openbar"
description "Openbar"
default_attributes :active_applications =>  {"open_bar" => {"env" =>  "production"}},

:applications => {
  :open_bar => {
    :gems => ['fast_xs']
  }
}