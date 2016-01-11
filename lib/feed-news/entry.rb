require 'uri'

module FeedNews
  Entry = Struct.new(:id, :title, :relative_uri, :feed) do
    def self.map(doc, feed)
      e = new

      e.id = doc.xpath('id').text
      e.title = doc.xpath('title').text
      e.feed = feed
      e.relative_uri = doc.xpath('link/@href').text

      e
    end

    def uri
      URI.join(feed.uri, relative_uri)
    end

    def to_s
      "#{title}: #{uri}"
    end
  end
end
