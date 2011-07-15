require "rss-growl/version"
require 'open-uri'
require 'simple-rss'
require 'growl'

class RSSGrowl
  attr_accessor :url, :settings
  def initialize(url,opts={})
    @settings = {
      :interval => 60
    }.update(opts)
    $0 = "rss-growl: #{settings[:title]}"
    @url = url
  end
  def get_latest(url)
    fh = open(url)
    sr = SimpleRSS.new(fh)
    fh.close
    sr.entries.first
  end
  def root
    File.realpath(File.join(File.dirname(__FILE__), '..'))
  end
  def rss_img
    "#{root}/images/rss.gif"
  end
  def run
    unique = ''
    loop do
      latest = get_latest(url)
      if unique != latest[:pubDate]
        title = settings[:title] || latest[:title]
        message = sanitized_title(latest[:title])
        Growl.notify message, title: title, icon: rss_img, sticky: true
        unique = latest[:pubDate]
      end
      sleep settings[:interval]
    end
  end
  def sanitized_title(title)
    title.gsub(/'/,"")
  end
end
