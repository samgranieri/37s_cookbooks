directory "/u/logs" do
  action :create
  mode 0755
  owner "app"
  group "app"
end

directory "/u/logs/apps" do
  action :create
  mode 0775
  owner "app"
  group "www-data"
end


if node[:applications]
  require_recipe "rails_passenger"
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