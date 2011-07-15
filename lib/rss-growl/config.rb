class RSSGrowl
  class Config
    attr_accessor :settings
    def initialize(file=nil)
      file = "#{ENV['HOME']}/.rss_growl"
      missing_config unless File.exists? file
      @settings = YAML.load(fh = open(file))
      fh.close
    end
    def size
      settings.size
    end
    def each
      settings.each do |k,v|
        yield k,v
      end
    end

    def missing_config
      puts %|create .rss_growl with example format:
        Woot:
          url: http://www.woot.com/Blog/Feed.ashx
          interval: 60
        Ron Paul:
          url: http://www.ronpaul2012.com/feed
      |
    end
  end
end
