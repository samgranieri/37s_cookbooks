log_level        :info
log_location     STDOUT
file_store_path  "/var/chef/file_store"
file_cache_path  "/var/chef/cache"
ssl_verify_mode  :verify_none
registration_url "https://noc/chef"
openid_url       "https://noc/chef"
template_url     "https://noc/chef"
remotefile_url   "https://noc/chef"
search_url       "https://noc/chef"
node_name        `hostname -s`


