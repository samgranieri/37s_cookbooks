
package "gitosis"

user "gitosis" do
  action :remove
end

group "gitosis" do
  action :remove
end

remote_file "/usr/share/python-support/gitosis/gitosis-0.2-py2.5.egg/gitosis/access.py" do
  source "access.py"
  owner "root"
  group "root"
  mode 0755
end