postfix Mash.new unless attribute?("postfix")
postfix[:myorigin] = fqdn unless postfix.has_key?(:myorigin)