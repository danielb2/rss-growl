class RSSGrowl
  class RSS
    attr_accessor :rss
    def initialize(url)
      fh = open(url)
      @rss = Nokogiri::XML(fh)
      fh.close
    end
    def title
      rss.css('item title').first.content
    end
    def unique_field
      rss.css('item title').first.content
    end
  end
end
