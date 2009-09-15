name "backpack-app"
description "Backpack Application Server"
recipes "cron"

override_attributes :cron => {
                      :jobs => {
                        :cgi_stale_upload_cleaner => {
                          :command => '/usr/bin/find /tmp -name CGI.\* -mmin +15 -delete',
                          :minute => '*/15',
                          :user => 'root'
                        }
                      }
                    }
