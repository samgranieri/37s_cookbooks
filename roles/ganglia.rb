name "ganglia"
description "Ganglia System Monitoring"
default_attributes :ganglia => {
  :cluster_name => '37signals',
  :clusters => [
                { :name => 'Basecamp', :interval => 60, :nodes => [ 'bc-01', 'bc-02', 'bc-03', 'bc-04' ] }
               ],
  :servers  => [ '192.168.1.159:3737', '192.168.1.153:3737' ]
}
