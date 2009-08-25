name "basecamp-app"
description "Basecamp Application Server"
recipes "cron"

override_attributes :apache => { :deflate => { :disable => true, :mime_types => [] }},
                    :cron => {
                      :jobs => {
                        :rack_multipart_cleaner => {
                          :command => '/usr/bin/find /tmp -name RackMultipart.\* -mmin +15 -delete',
                          :minute => '*/15',
                          :user => 'root'
                        },
                        :upload_processor_cleaner => {
                          :command => '/usr/bin/find /u/apps/basecamp/shared/tmp/uploads -type f -mmin +30 -delete',
                          :minute => '*/15',
                          :user => 'root'
                        }
                      }
                    }
