log_level        :info
log_location     STDOUT
file_store_path  "/var/chef/file_store"
file_cache_path  "/var/chef/cache"
ssl_verify_mode  :verify_none
registration_url "http://noc2:4000"
openid_url       "http://noc2:4001"
template_url     "http://noc2:4000"
remotefile_url   "http://noc2:4000"
search_url       "http://noc2:4000"
node_name        `hostname -s`.chomp
validation_token   "bd1ea65f20d3c20db41bfcc86602afab"
