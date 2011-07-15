class RSSGrowl
  class Config
    attr_accessor :settings
    def initialize(file=nil)
      missing_config unless File.exists? cfg_file
      @settings = YAML.load(fh = open(cfg_file))
      fh.close
    end
    def cfg_file
      "#{ENV['HOME']}/.rss_growl"
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
      puts %|create #{cfg_file} with example format:
        Woot:
          url: http://www.woot.com/Blog/Feed.ashx
          interval: 60
        Ron Paul:
          url: http://www.ronpaul2012.com/feed
      |
      exit(1)
    end
  end
end
