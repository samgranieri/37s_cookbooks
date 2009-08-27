#!/usr/bin/ruby

require 'net/imap'
require 'yaml'

IMAP_HOST  = 'imap.gmail.com'
IMAP_PORT  = 993
IMAP_USER  = '37signals.support@gmail.com'
IMAP_PASS  = '38jAtrUy'
IMAP_SSL   = 'true'
CHECKPOINT = '/u/dev/support_check/checkpoint.yml'
THRESHOLD  = 100
RECIPIENTS = '3125056062@txt.att.net,8472087051@txt.att.net'

status = ( File.exists?(CHECKPOINT) ? YAML.load_file(CHECKPOINT) : { :last => 0, :alerted_at => nil } )
imap = Net::IMAP.new(IMAP_HOST, IMAP_PORT, IMAP_SSL)
imap.login(IMAP_USER, IMAP_PASS)
unread = imap.status('INBOX', ['UNSEEN'])['UNSEEN']

if (unread > THRESHOLD)
  if status[:alerted_at].nil?
    puts "Sending alert."
    message = "Warning: #{unread} unread support messages in inbox."
    IO.popen("/usr/bin/mail #{RECIPIENTS}", "w") do |mail|
      mail.puts message
    end
    status[:alerted_at] = Time.now.to_i
  end
elsif !status[:alerted_at].nil? && (unread < THRESHOLD)
  status[:alerted_at] = nil
end

status[:last] = unread

File.open(CHECKPOINT, "w+") do |file|
  YAML.dump(status, file)
end
