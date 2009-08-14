name "cf-poll"
description "CF Solr search server"
recipes "erlang", "rails::app_dependencies"

default_attributes :active_groups => {:app => {:enabled => true}},
                   :erlang => {
                     :applications => [
                        { 
                         "name" => "campfire_poller",
                         "description" => "Campfire poller server",
                         "base_dir" => "/u/apps/campfire_poller",
                         "supervisor_name" => "poller",
                         "erlang_args" => "+K true +A 32 -smp enable",
                         "fullsweep_after" => "0"
                       }
                     ],
                     "cookie" => "HpYSdvIxrd34QGFIJMFv"
                   },
                   "active_applications" => { "campfire" => { "env" => "production" }}
