require 'pstore'

module FeedNews
  class Repository
    def initialize(file)
      @latest = PStore.new(file)
    end

    def read(uri)
      @latest.transaction(true) do
        @latest[uri.to_s]
      end
    end

    def update(uri, id)
      @latest.transaction do
        @latest[uri.to_s] = id
      end
    end

    def seen?(entry)
      if entry.id == read(entry.uri)
        true
      else
        update(entry.uri, entry.id)
        false
      end
    end
  end
end
