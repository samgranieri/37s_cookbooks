unicorn Mash.new unless attribute?(:unicorn)
ruby_bin_path languages[:ruby]][:ruby_bin].gsub("/ruby", "")

default[:unicorn][:version] = "0.93.1"
default[:unicorn][:worker_count] = 6
default[:unicorn][:timeout] = 10