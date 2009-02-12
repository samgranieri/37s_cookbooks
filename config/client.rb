log_level        :info
log_location     "/var/chef/log/client.log"
file_store_path  "/var/chef/file_store"
file_cache_path  "/var/chef/cache"
ssl_verify_mode  :verify_none
registration_url "http://chef"
openid_url       "http://chef"
template_url     "http://chef"
remotefile_url   "http://chef"
search_url       "http://chef"
node_name        `hostname -f`.chomp
validation_token   "bd1ea65f20d3c20db41bfcc86602afab"