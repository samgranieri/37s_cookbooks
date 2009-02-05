include_recipe "rails_passenger"

%w(sites apps).each do |path|
  Dir.open("/u/#{path}").entries.each do |site|
    %w(staging production).each do |role|
      config_path = role == "staging" ? "/u/staging/#{path}/#{site}/current/config/apache/#{role}.conf" : "/u/#{path}/#{site}/current/config/apache/#{role}.conf"
      if File.exists?(config_path)
        link "#{config_path}" do
          to "#{node[:apache][:dir]}/sites-available/#{site}_#{role}.conf"
        end
        apache_site "#{site}_#{role}"
      end
    end
  end
end

