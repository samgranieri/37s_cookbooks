name "basecamp-app"
description "Basecamp Application Server"
recipes "cron"

override_attributes :apache => { :deflate => { :disable => true, :mime_types => [] }},
                    :cron => {
                      :jobs => {
                        :rack_multipart_cleaner => {
                          :command => '/usr/bin/find /u/apps/basecamp/shared/tmp -name RackMultipart.\* -mmin +15 -delete',
                          :minute => '*/15',
                          :user => 'root'
                        }
                      }
                    }
