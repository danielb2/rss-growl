require "rss-growl/version"
require 'open-uri'
require 'growl'
require 'nokogiri'
require 'rss-growl/rss'
require 'rss-growl/config'
require 'yaml'

class RSSGrowl
  attr_accessor :url, :settings
  def initialize(url,opts={})
    @settings = opts
    @settings[:interval] ||= 60
    $0 = "rss-growl: #{settings[:title]}"
    @url = url
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
      rss = RSSGrowl::RSS.new(url, settings)
      if unique != rss.unique_field
        title = settings[:title] || rss.title
        message = sanitized_title(rss.title)
        Growl.notify message, title: title, icon: rss_img, sticky: true
        unique = rss.unique_field
      end
      sleep settings[:interval]
    end
  end
  def sanitized_title(title)
    title.gsub(/'/,"")
  end
end
