name "basecamp"
description "Basecamp"
default_attributes  :active_applications =>  {"basecamp" =>  {"env" => "production"}},
                    :postfix => {
                      :virtual_domains => {
                        "/^([^@]+\.)?(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/" => "VIRTUAL",
                       "/^P\d+-reply@(([^@])+\.)basecamphq\.com$/" => "basecamp@localhost",
                       "/^(basecamp)|([Uu]\d+[PpIiMm]\d+-reply)@([^\.]+\.)(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/" => "basecamp@localhost",
                       "/^do-not-reply(.+)?@([^\.]+\.)*(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/" => "devnull",
                       "/^notifications@basecamphq\.com$/" => "devnull",
                       "/^postmaster@(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/" => "postmaster@37signals.com",
                       "/^support@(updatelog|clientsection|seework|grouphub|projectpath|basecamphq)\.com$/" => "37signals.support@gmail.com",
                       "/^requests@basecamphq\.com$/" => "37signals.support@gmail.com",
                       "/^errors?@basecamphq\.com$/" => "37signals.support@gmail.com"
                      }
                    },
                    :applications => {
                      :basecamp => {
                        :syslog_files => {:completed => true, :thumbnails => true, :logsort => true, :haproxy => true, :memcache => true},
                        :gems => ['fast_xs', ['hpricot', '0.8.1'], 'aws-s3', 'ruby-prof', ['net-ssh', '1.1.4'], ['net-sftp', '1.1.1'], ['tzinfo', '0.3.9']],
                        :packages => ['imagemagick', 'elinks', 'zip'],
                        :symlinks => {
                        '/usr/local/bin/convert' => '/usr/bin/convert',
                        '/usr/local/bin/identify' => '/usr/bin/identify',
                        '/usr/local/bin/composite' => '/usr/bin/composite',
                        '/usr/local/bin/elinks' => '/usr/bin/elinks'},
                        :apache_modules => ["auth_token", "xsendfile", "rewrite"],
                        :disable_apache_modules => ["deflate"]
                      }
                    },
                    :apache => {:listen_ports => [80]}
override_attributes :passenger => { :tune_gc => false }
