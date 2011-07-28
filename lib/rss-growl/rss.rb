class RSSGrowl
  class RSS
    attr_accessor :rss
    def initialize(url, settings)
      open(url) do |fh|
        @rss = Nokogiri::XML(fh)
      end
    end
    def title
      rss.css('item title').first.content
    end
    def unique_field
      rss.css('item title').first.content
    end
  end
end
