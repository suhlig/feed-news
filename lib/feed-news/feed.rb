module FeedNews
  Feed = Struct.new(:title, :uri, :entries) do
    def self.map(doc)
      f = new
      f.title = doc.xpath('//feed/title').text
      f.uri = doc.xpath('//feed/link[@rel = "self"]/@href').text

      f.entries = doc.xpath('//feed/entry').map do |entry|
        Entry.map(entry, f)
      end

      f
    end

    def latest
      entries.first
    end
  end
end
