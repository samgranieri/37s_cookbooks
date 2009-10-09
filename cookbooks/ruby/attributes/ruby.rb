# twitter GC settings from http://blog.evanweaver.com/articles/2009/04/09/ruby-gc-tuning/
ruby Mash.new unless attribute?("ruby")
default.ruby[:gc] = Mash.new
default.ruby[:gc][:heap_min_slots] = 500000
default.ruby[:gc][:heap_slots_increment] = 250000
default.ruby[:gc][:heap_slots_growth_factor] = 1
default.ruby[:gc][:malloc_limit] = 50000000
default.ruby[:gc][:heap_free_min] = 4096