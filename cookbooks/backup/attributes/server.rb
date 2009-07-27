backup Mash.new unless attribute?(:backup?)
backup[:devices] = Mash.new unless backup.has_key?(:devices)
