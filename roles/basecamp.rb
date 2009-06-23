name "basecamp"
description "Basecamp"
default_attributes :active_applications =>  {"basecamp" =>  {"env" => "production"}},
                   :syslog_files => {:completed => true, :thumbnails => true, :logsort => true, :haproxy => true, :memcache => true},
                    :gems => ['fast_xs', 'hpricot', 'aws-s3', 'ruby-prof', ['net-ssh', '1.1.4'], ['net-sftp', '1.1.1'], ['tzinfo', '0.3.9']],
                    :packages => ['imagemagick', 'elinks', 'zip'],
                    :symlinks => {
                      '/usr/local/bin/convert' => '/usr/bin/convert',
                      '/usr/local/bin/identify' => '/usr/bin/identify',
                      '/usr/local/bin/composite' => '/usr/bin/composite',
                      '/usr/local/bin/elinks' => '/usr/bin/elinks',
                      '/u/depot' => '/u/nfs/file1/depot'},
                    :apache_modules => ["auth_token", "xsendfile", "rewrite"],
                    :apache => {:listen_ports => []}
