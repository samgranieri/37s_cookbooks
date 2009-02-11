cookbook_path     "/var/chef/cookbooks"
node_path         "/var/chef/nodes"
#search_index_path File.join(File.dirname(__FILE__), "search_index")
log_level         :info
file_store_path  "/var/chef"
file_cache_path  "/var/chef"
node_name        `hostname -f`.chomp

Chef::Log::Formatter.show_time = false