# Is this valid for all platforms? Is it not just rabbitmq on some platform?
# Valid for ubuntu, *probably* debian and EL5
# http://download.fedora.redhat.com/pub/epel/5/x86_64/repoview/letter_r.group.html
package "rabbitmq-server"

service "rabbitmq-server" do
  if platform?("centos","redhat","fedora")
    start_command "/sbin/service rabbitmq-server start &> /dev/null"
    stop_command "/sbin/service rabbitmq-server stop &> /dev/null"
  end
  supports [ :restart, :status ]
  action [ :enable, :start ]
end
