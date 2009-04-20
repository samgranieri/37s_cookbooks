gem_package "git_remote_branch"

node[:build].each do |name, config|
  config[:packages].each do |pack|
    package pack
  end
end