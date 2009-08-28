require 'marshmallow'
require 'singleton'

module Campfire
  class Bot
    def initialize(username, password)
      @username = username
      @password = password
      set_defaults
      connect
    end
    
    def set_defaults
      @domain = '37s'
      @room   = ENV['SPITFIRE_ROOM'] || 1      
    end
    
    def connect
      @bot = Marshmallow.new(:domain => @domain, :ssl => true)
      @bot.login(:method => :login, :username => @username, :password => @password, :room => @room)
    end
    
    # Extend say to work with multiple lines.
    def say(*lines)
      lines.each{ |line| @bot.say(line) }
      nil
    end
    
    # Proxy everything to the bot.
    def method_missing(m, *args)
      @bot.send(m, *args)
    end
  
    # Proxy class methods to the singleton instance.
    def self.method_missing(m, *args)
      instance.send(m, *args)
    end
  end
end
