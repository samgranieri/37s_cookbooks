# support tools

directory "/u/support" do
  owner "app"
  group "app"
  mode 0755
end

directory "/u/support/bin" do
  owner "app"
  group "app"
  mode 0755
end

remote_file "/u/support/bin/gmail_queue_check.rb" do
  source "support_check.rb"
  mode 0755
end

cron "support email queue check" do
  command "/u/support/bin/gmail_queue_check.rb"
  minute "*/10"
end