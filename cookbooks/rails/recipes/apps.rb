if node[:applications]
  node[:applications].each do |app, config|
    if config[:type] == :mongrel
      # mongrel_app app do
      #   config config[:env]
      # end
    else
      passenger_app app do
        config config[:env]
      end
    end
  end
end