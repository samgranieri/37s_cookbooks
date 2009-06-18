name "ec2-us"
description "Servers in the EC2 environment"
recipes "ec2::filesystems"
default_attributes :nameservers => ['10.252.194.239'],
                   :public_domain => "ec2-us.37signals.com",
                   :hosts => {:entries => [['10.252.194.239', 'noc']]}