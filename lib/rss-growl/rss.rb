class RSSGrowl
  class RSS
    attr_accessor :rss
    def initialize(url)
      open(url) do |fh|
        @rss = Nokogiri::XML(fh)
      end
    end
    # do we use entry or item?
    def type
      return @type if @type
      @type = 'item' if rss.css('item').count > 0
      @type = 'entry' if rss.css('entry').count > 0
      return @type
    end
    def title
      rss.css("#{type} title").first.content
    end
    def unique_field
      rss.css("#{type} title").first.content
    end
  end
end
