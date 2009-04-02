mogilefs Mash.new unless attribute?("mogilefs")

mogilefs[:path] = "/u/apps/mogilefs" unless mogilefs.has_key?(:path)
mogilefs[:trackers] = [ 'mogilefs:6001' ] unless mogilefs.has_key?(:trackers)
mogilefs[:pkg] = "http://dist/packages/mogilefs.tar.bz2" unless mogilefs.has_key?(:pkg)

mogilefs[:mogilefsd] = Mash.new unless mogilefs.has_key?(:mogilefsd)
mogilefs[:mogilefsd][:db_dsn] = "DBI:mysql:mogilefs:host=mogile-db" unless mogilefs[:mogilefsd].has_key?(:db_dsn)
mogilefs[:mogilefsd][:db_user] = "mogile" unless mogilefs[:mogilefsd].has_key?(:db_user)
mogilefs[:mogilefsd][:db_pass] = "M1J4utYQnRpD8gy" unless mogilefs[:mogilefsd].has_key?(:db_pass)
mogilefs[:mogilefsd][:conf_port] = 6001 unless mogilefs[:mogilefsd].has_key?(:conf_port)
mogilefs[:mogilefsd][:listener_jobs] = 10 unless mogilefs[:mogilefsd].has_key?(:listener_jobs)
mogilefs[:mogilefsd][:delete_jobs] = 1 unless mogilefs[:mogilefsd].has_key?(:delete_jobs)
mogilefs[:mogilefsd][:replicate_jobs] = 5 unless mogilefs[:mogilefsd].has_key?(:replicate_jobs)
mogilefs[:mogilefsd][:reaper_jobs] = 1 unless mogilefs[:mogilefsd].has_key?(:reaper_jobs)
mogilefs[:mogilefsd][:mog_root] = "/var/mogdata" unless mogilefs[:mogilefsd].has_key?(:mog_root)

mogilefs[:mogstored] = Mash.new unless mogilefs.has_key?(:mogstored)
mogilefs[:mogstored][:http_listen] = "0.0.0.0:7500" unless mogilefs[:mogstored].has_key?(:http_listen)
mogilefs[:mogstored][:mgmt_listen] = "0.0.0.0:7501" unless mogilefs[:mogstored].has_key?(:mgmt_listen)
mogilefs[:mogstored][:doc_root] = "/var/mogdata" unless mogilefs[:mogstored].has_key?(:docroot)

perlbal = Mash.new unless attribute?("perlbal")
perlbal[:address] = "0.0.0.0:11200" unless mogilefs[:perlbal].has_key?(:address)
