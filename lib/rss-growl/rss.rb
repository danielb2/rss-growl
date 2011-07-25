class RSSGrowl
  class RSS
    attr_accessor :rss
    def initialize(url, settings)
      begin
        open(url) do |fh|
          @rss = Nokogiri::XML(fh)
        end
      rescue SocketError
        puts "Warning: unable to establish socket connection. Trying again in #{settings[:interval]}"
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
