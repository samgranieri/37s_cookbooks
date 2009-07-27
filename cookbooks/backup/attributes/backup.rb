backup Mash.new unless attribute?(:backup?)
backup[:devices] = [] unless backup.has_key?(:devices)
