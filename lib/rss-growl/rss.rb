class RSSGrowl
  class RSS
    attr_accessor :rss
    def initialize(url)
      fh = open(url)
      @rss = SimpleRSS.new(fh)
      fh.close
    end
    def title
      rss.entries.first[:title]
    end
    def unique_field
      rss.entries.first[:pubDate]
    end
  end
end
