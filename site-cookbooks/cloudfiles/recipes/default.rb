gem_package "cloudfiles"
gem_package "thor"
package "gnupg"

remote_file "/usr/local/bin/cloudfiles" do
  mode 0755
end