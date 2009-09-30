nagios Mash.new unless attribute?("nagios")

nagios[:plugins_dir] = "/u/nagios/plugins"

nagios[:checks] = Mash.new unless nagios.has_key?(:checks)
nagios[:checks][:load] = Mash.new unless nagios[:checks].has_key?(:load)
nagios[:checks][:memory] = Mash.new unless nagios[:checks].has_key?(:memory)
nagios[:checks][:haproxy_queue] = Mash.new unless nagios[:checks].has_key?(:haproxy_queue)

nagios[:checks][:memory][:critical] = 150 unless nagios[:checks][:memory].has_key?(:critical)
nagios[:checks][:memory][:warning] = 250 unless nagios[:checks][:memory].has_key?(:warning)

nagios[:checks][:load][:critical] = "30,20,10" unless nagios[:checks][:load].has_key?(:critical)
nagios[:checks][:load][:warning] = "15,10,5" unless nagios[:checks][:load].has_key?(:warning)

nagios[:checks][:haproxy_queue][:critical] = "10" unless nagios[:checks][:haproxy_queue].has_key?(:critical)
nagios[:checks][:haproxy_queue][:warning] = "1" unless nagios[:checks][:haproxy_queue].has_key?(:warning)