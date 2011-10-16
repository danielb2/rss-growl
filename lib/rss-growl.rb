require "rss-growl/version"
require 'open-uri'
require 'growl'
require 'nokogiri'
require 'rss-growl/rss'
require 'rss-growl/config'
require 'yaml'

class RSSGrowl
  attr_accessor :url, :settings
  def initialize(settings)
    @settings = settings
    @settings['interval'] ||= 60
    @settings['sticky'] = true unless [TrueClass,FalseClass].include? @settings['sticky'].class
    $0 = "rss-growl: #{settings['title']}"
    @url = settings['url']
    @foo = RSSGrowl::Config.new(url)
  end
  def self.root
    File.realpath(File.join(File.dirname(__FILE__), '..'))
  end
  def root
    self.class.root
  end
  def rss_img
    "#{root}/images/rss.gif"
  end
  def run
    unique = ''
    loop do
      begin
        rss = RSSGrowl::RSS.new(url)
        if unique != rss.unique_field
          title = settings['title'] || rss.title
          message = sanitized_title(rss.title)
          Growl.notify message, title: title, icon: rss_img, sticky: settings['sticky']
          unique = rss.unique_field
        end
      rescue SocketError, SystemCallError, OpenURI::HTTPError, Errno::EHOSTUNREACH, EOFError
        puts "Warning: unable to establish connection. Trying again in #{settings['interval']}"
      end
      sleep settings['interval']
    end
  end
  def sanitized_title(title)
    title.gsub(/'/,"")
  end
end
