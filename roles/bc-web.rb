name "bc-web"
description "Basecamp web server"
recipes "syslog::client", "rails::apps"
default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}},
                   :web_only => true,
                   :apache => {
                     :listen_ports => [],
                     :worker => {:startservers => 30,
                                 :maxclients => 1536,
                                 :serverlimit => 64,
                                 :minsparethreads => 250,
                                 :maxsparethreads => 400,
                                 :threadsperchild => 24,
                                 :maxrequestsperchild => 0
                                 }
                    }
