
package "gitosis"

user "gitosis" do
  action :remove
end

group "gitosis" do
  action :remove
end

# Install local modifications to Gitosis
%W(access.py serve.py).each do |patched|
  remote_file "/usr/share/python-support/gitosis/gitosis-0.2-py2.5.egg/gitosis/#{patched}" do
    source "#{patched}"
    owner "root"
    group "root"
    mode 0755
  end
end
