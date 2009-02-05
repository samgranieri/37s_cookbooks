base Mash.new unless attribute?("base")

base[:sysadmin_email] = "sysadmins@37signals.com"
base[:sysadmin_sms_email] = "sysadmins@37signals.com"
base[:campfire_subdomain] = "37s"
base[:campfire_email] = "monitoring@37signals.com"
base[:campfire_password] = "0hs0tast33"
base[:sysadmin_campfire_room] = "System Administration"
base[:clickatell_username] = "37signals"
base[:clickatell_api_id] = "3131956"
base[:clickatell_password] = "EIJVhiv4"

users Mash.new unless attribute?("users")
users = Array.new