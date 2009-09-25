#!/usr/local/bin/ruby

$LOAD_PATH.unshift File.dirname(__FILE__)
require 'campfire'

BLANK = "0" * 40
MASTER = "refs/heads/master"

def analyze_commits
  refs = {}

  ARGF.each do |line|
    old, new, ref = line.strip.split(/\s/)

    refs[ref] = { :old => old, :new => new, :commits => [] }

    if old == BLANK
      if ref == MASTER
        refs[ref].update :action => :new_project, :range => new
      else
        refs[ref].update :action => :new_branch, :range => "master..#{new}"
      end
    elsif new == BLANK
      refs[ref].update :action => :deleted_branch
    else
      refs[ref].update :action => :update, :range => "#{old}..#{new}"
    end

    if refs[ref][:range]
      refs[ref][:message] = `git whatchanged --name-status --pretty=format:"%h: %s (%ar)" #{refs[ref][:range]}`.strip
      refs[ref][:commits] = refs[ref][:message].scan(/^([0-9a-f]+):/).map { |c| c.first }
    end
  end

  result = { :type => :summary, :refs => refs,
    :ref => refs.keys.first, :info => refs.values.first }

  if refs.length == 1
    action = result[:info][:action]
    commits = result[:info][:commits]

    if action == :new_project && commits.empty?
      result[:type] = :new_project
    elsif action == :new_branch && commits.empty?
      result[:type] = :new_branch
    elsif action == :deleted_branch
      result[:type] = :deleted_branch
    elsif commits.empty?
      result[:type] = :empty
    end
  elsif refs.empty?
    result[:type] = :empty
  end

  return result
end

def format_analysis(pusher, project, url, analysis)
  case analysis[:type]
  when :new_project then
    { :subject => "#{pusher} created an empty project at #{project}:#{analysis[:ref]}" }
  when :new_branch then
    { :subject => "#{pusher} created an empty branch in #{project} at #{analysis[:ref]}" }
  when :deleted_branch then
    { :subject => "#{pusher} deleted the #{analysis[:ref]} branch from #{project}" }
  when :empty then
    { :subject => "#{pusher} pushed zero commits to #{project}" }
  when :summary then
    message = ""
    commits = []
    analysis[:refs].keys.sort.each do |ref|
      data = analysis[:refs][ref]

      case data[:action]
      when :deleted_branch then verb = "deletion of"
      when :new_branch then verb = "creation of"
      else verb = "changes to"
      end

      title = "#{verb} #{project}:#{ref}"
      dashes = 66 - title.length
      message << "-- #{title} " << "-" * dashes << "\n"

      if data[:commits].any?
        message << data[:message] << "\n\n"
        commits.concat(data[:commits])
      end
    end

    subject = "#{pusher} pushed"

    if commits.empty?
      subject << " changes"
    elsif commits.length == 1
      subject << " " << url << commits.first
    else
      subject << " #{commits.length} commits"
    end

    subject << " to #{project}"

    if commits.length > 1
      if commits.length > 13
        others = commits.length - 10
        last = commits.last
        commits = commits.first(10)
      end

      subject << " ("
      subject << commits.map { |commit| url + commit }.join(", ")
      subject << ", and #{others} more commits, ending with #{url}#{last}" if others
      subject << ")"
    end

    { :subject => subject, :message => message }
  else
    raise "do not know how to format an analysis of type #{analysis[:type].inspect}"
  end
end

pusher  = ENV['GITOSIS_USER'] || ENV['USER']
project = File.basename(Dir.pwd, ".git")
url = "https://dev.37signals.com/c/#{project}/"

analysis = analyze_commits
output = format_analysis(pusher, project, url, analysis)

$stdout.puts output[:subject]
$stdout.puts output[:message] if output[:message]

$stdout.puts "-" * 70
$stdout.puts "sending summary to campfire..."
$stdout.flush

Campfire::Bot.say(output[:subject])
Campfire::Bot.paste(output[:message]) if output[:message]

$stdout.puts "done!"
