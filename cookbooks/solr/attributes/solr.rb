solr Mash.new unless attribute?(:solr)
solr[:root] = "/u/solr" unless solr.has_key?(:root)

solr[:data_device] = nil unless solr.has_key?(:data_device)

solr[:war] = Mash.new unless solr.has_key?(:war)
solr[:war][:file] = "apache-solr-1.3.0.war" unless solr[:war].has_key?(:file)
solr[:war][:url] = "http://dist/solr" unless solr[:war].has_key?(:url)
