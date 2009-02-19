if node[:applications]
  puts node[:applications].inspect
  node[:applications].each do |app, config_hash|
    if config_hash[:type] == :mongrel
      # mongrel_app app do
      #   config config[:env]
      # end
    else
      passenger_app app do
        conf config_hash
      end
    end
  end
end